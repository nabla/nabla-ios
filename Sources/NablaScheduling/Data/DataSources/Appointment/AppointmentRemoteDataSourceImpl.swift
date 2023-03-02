import Combine
import Foundation
import NablaCore

final class AppointmentRemoteDataSourceImpl: AppointmentRemoteDataSource {
    // MARK: Internal
    
    func watchAppointments(state: AppointmentStateFilter) -> AnyPublisher<AnyResponse<PaginatedList<RemoteAppointment>, GQLError>, GQLError> {
        switch state {
        case .upcoming: return watchUpcomingAppointments()
        case .finalized: return watchFinalizedAppointments()
        }
    }
    
    func watchAppointment(withId id: UUID) -> AnyPublisher<RemoteAppointment, GQLError> {
        gqlClient.watch(
            query: GQL.GetAppointmentQuery(id: id),
            policy: .returnCacheDataAndFetch
        )
        .map(\.appointment.appointment.fragments.appointmentFragment)
        .eraseToAnyPublisher()
    }
    
    func subscribeToAppointmentsEvents() -> AnyPublisher<RemoteAppointmentsEvent, Never> {
        gqlClient.subscribe(subscription: GQL.AppointmentsEventsSubscription())
            .compactMap(\.appointments?.event)
            .handleEvents(receiveOutput: { [weak self] event in
                self?.handle(event)
            })
            .eraseToAnyPublisher()
    }
    
    /// - Throws: ``GQLError``
    func createPendingAppointment(isPhysical: Bool, categoryId: UUID, providerId: UUID, date: Date) async throws -> RemoteAppointment {
        let response = try await gqlClient.perform(
            mutation: GQL.CreatePendingAppointmentMutation(
                isPhysical: isPhysical,
                categoryId: categoryId,
                providerId: providerId,
                startAt: date
            )
        )
        let fragment = response.createPendingAppointment.appointment.fragments.appointmentFragment
        try await insert(fragment)
        return fragment
    }
    
    /// - Throws: ``GQLError``
    func schedulePendingAppointment(withId appointmentId: UUID) async throws -> RemoteAppointment {
        let response = try await gqlClient.perform(
            mutation: GQL.SchedulePendingAppointmentMutation(appointmentId: appointmentId)
        )
        let appointment = response.schedulePendingAppointment.appointment.fragments.appointmentFragment
        if appointment.state.asPendingAppointment == nil {
            // If the appointment's state change, we must manually insert it in our upcoming/finalized cached queries
            try await insert(appointment)
        }
        return appointment
    }
    
    /// - Throws: ``GQLError``
    func cancelAppointment(withId appointmentId: UUID) async throws {
        let response = try await gqlClient.perform(mutation: GQL.CancelAppointmentMutation(appointmentId: appointmentId))
        try await remove(appointmentWithId: response.cancelAppointment.appointmentUuid)
    }
    
    /// - Throws: ``GQLError``
    func getAvailableLocations() async throws -> RemoteAvailableLocations {
        let response = try await gqlClient.fetch(
            query: GQL.GetAvailableLocationsQuery(),
            policy: .fetchIgnoringCacheData
        )
        return response.appointmentAvailableLocations
    }
    
    // MARK: Init
    
    init(
        gqlClient: GQLClient,
        gqlStore: GQLStore,
        logger: Logger
    ) {
        self.gqlClient = gqlClient
        self.gqlStore = gqlStore
        self.logger = logger
    }
    
    // MARK: - Private
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    private let logger: Logger
    
    private enum Constants {
        static let numberOfItems = 50
    }
    
    private enum Queries {
        static var getUpcomingAppointmentsLocalCacheMutation: GQL.GetUpcomingAppointmentsLocalCacheMutation {
            GQL.GetUpcomingAppointmentsLocalCacheMutation(page: .init(cursor: .none, numberOfItems: .some(Constants.numberOfItems)))
        }
        
        // TODO: Refactor backend to use the same query for both and avoid code duplicate
        static var getUpcomingAppointmentsRootQuery: GQL.GetUpcomingAppointmentsQuery {
            getUpcomingAppointmentsQuery(cursor: nil)
        }

        static func getUpcomingAppointmentsQuery(cursor: String?) -> GQL.GetUpcomingAppointmentsQuery {
            GQL.GetUpcomingAppointmentsQuery(page: .init(cursor: cursor.nabla.asGQLNullable(), numberOfItems: .some(Constants.numberOfItems)))
        }
        
        static var getFinalizedAppointmentsLocalCacheMutation: GQL.GetFinalizedAppointmentsLocalCacheMutation {
            GQL.GetFinalizedAppointmentsLocalCacheMutation(page: .init(cursor: .none, numberOfItems: .some(Constants.numberOfItems)))
        }

        static var getFinalizedAppointmentsRootQuery: GQL.GetFinalizedAppointmentsQuery {
            getFinalizedAppointmentsQuery(cursor: nil)
        }

        static func getFinalizedAppointmentsQuery(cursor: String?) -> GQL.GetFinalizedAppointmentsQuery {
            GQL.GetFinalizedAppointmentsQuery(page: .init(cursor: cursor.nabla.asGQLNullable(), numberOfItems: .some(Constants.numberOfItems)))
        }
    }
    
    private func watchUpcomingAppointments() -> AnyPublisher<AnyResponse<PaginatedList<RemoteAppointment>, GQLError>, GQLError> {
        gqlClient.watchAndUpdate(
            query: Queries.getUpcomingAppointmentsRootQuery
        )
        .map { response -> AnyResponse<PaginatedList<RemoteAppointment>, GQLError> in
            let appointments = response.data.upcomingAppointments
            let data = appointments.data.map(\.fragments.appointmentFragment)
                
            var fetchMore: (() async throws -> Void)?
            if let cursor = appointments.nextCursor {
                fetchMore = { [weak self] in
                    try await self?.fetchMoreUpcomingAppointments(cursor: cursor)
                }
            }

            let list = PaginatedList<RemoteAppointment>(
                elements: data,
                loadMore: fetchMore
            )
            return .init(
                data: list,
                isDataFresh: response.isDataFresh,
                refreshingState: response.refreshingState
            )
        }
        .eraseToAnyPublisher()
    }
    
    private func watchFinalizedAppointments() -> AnyPublisher<AnyResponse<PaginatedList<RemoteAppointment>, GQLError>, GQLError> {
        gqlClient.watchAndUpdate(
            query: Queries.getFinalizedAppointmentsRootQuery
        )
        .map { response -> AnyResponse<PaginatedList<RemoteAppointment>, GQLError> in
            let appointments = response.data.pastAppointments
            let data = appointments.data.map(\.fragments.appointmentFragment)
                
            var fetchMore: (() async throws -> Void)?
            if let cursor = appointments.nextCursor {
                fetchMore = { [weak self] in
                    try await self?.fetchMoreFinalizedAppointments(cursor: cursor)
                }
            }

            let list = PaginatedList<RemoteAppointment>(
                elements: data,
                loadMore: fetchMore
            )
            return .init(
                data: list,
                isDataFresh: response.isDataFresh,
                refreshingState: response.refreshingState
            )
        }
        .eraseToAnyPublisher()
    }
    
    private func fetchMoreUpcomingAppointments(cursor: String) async throws {
        let response = try await gqlClient.fetch(
            query: Queries.getUpcomingAppointmentsQuery(cursor: cursor),
            policy: .fetchIgnoringCacheCompletely
        )
        
        try await gqlStore.updateCache(
            cacheMutation: Queries.getUpcomingAppointmentsLocalCacheMutation,
            body: { cache in
                Self.append(response, to: &cache)
            }
        )
    }
    
    private func fetchMoreFinalizedAppointments(cursor: String) async throws {
        let response = try await gqlClient.fetch(
            query: Queries.getFinalizedAppointmentsQuery(cursor: cursor),
            policy: .fetchIgnoringCacheCompletely
        )
        
        try await gqlStore.updateCache(
            cacheMutation: Queries.getFinalizedAppointmentsLocalCacheMutation,
            body: { cache in
                Self.append(response, to: &cache)
            }
        )
    }
    
    private static func append(
        _ response: GQL.GetUpcomingAppointmentsQuery.Data,
        to cache: inout GQL.GetUpcomingAppointmentsLocalCacheMutation.Data
    ) {
        cache.upcomingAppointments.hasMore = response.upcomingAppointments.hasMore
        cache.upcomingAppointments.nextCursor = response.upcomingAppointments.nextCursor
        
        let existingAppointments = Set(cache.upcomingAppointments.data.map(\.fragments.appointmentFragment.id))
        
        for newAppointment in response.upcomingAppointments.data {
            guard !existingAppointments.contains(newAppointment.fragments.appointmentFragment.id) else { continue }
            cache.upcomingAppointments.data.append(.init(data: newAppointment.__data))
            cache.upcomingAppointments.data = cache.upcomingAppointments.data.nabla.sorted(\.fragments.appointmentFragment.scheduledAt, using: <)
        }
    }
    
    private static func append(
        _ response: GQL.GetFinalizedAppointmentsQuery.Data,
        to cache: inout GQL.GetFinalizedAppointmentsLocalCacheMutation.Data
    ) {
        cache.pastAppointments.hasMore = response.pastAppointments.hasMore
        cache.pastAppointments.nextCursor = response.pastAppointments.nextCursor
        
        let existingAppointments = Set(cache.pastAppointments.data.map(\.fragments.appointmentFragment.id))
        
        for newAppointment in response.pastAppointments.data {
            guard !existingAppointments.contains(newAppointment.fragments.appointmentFragment.id) else { continue }
            cache.pastAppointments.data.append(.init(data: newAppointment.__data))
            cache.pastAppointments.data = cache.pastAppointments.data.nabla.sorted(\.fragments.appointmentFragment.scheduledAt, using: >)
        }
    }
    
    private func handle(_ event: RemoteAppointmentsEvent) {
        if let createdEvent = event.asAppointmentCreatedEvent {
            Task(priority: .userInitiated) {
                try await self.insert(createdEvent.appointment.fragments.appointmentFragment)
            }
        } else if let updatedEvent = event.asAppointmentUpdatedEvent {
            Task(priority: .userInitiated) {
                try await self.updateFilteredQueriesAfterAppointmentChange(appointment: updatedEvent.appointment.fragments.appointmentFragment)
            }
        } else if let cancelledEvent = event.asAppointmentCancelledEvent {
            Task(priority: .userInitiated) {
                try await self.remove(appointmentWithId: cancelledEvent.appointmentId)
            }
        } else {
            logger.warning(message: "Unknown appointments event", extra: ["event": event.__typename])
        }
    }
    
    private func insert(_ appointment: RemoteAppointment) async throws {
        if appointment.state.asUpcomingAppointment != nil {
            try await insertUpcomingAppointment(appointment)
        } else if appointment.state.asFinalizedAppointment != nil {
            try await insertFinalizedAppointment(appointment)
        }
    }
    
    private func insertUpcomingAppointment(_ appointment: RemoteAppointment) async throws {
        try await gqlStore.updateCache(
            cacheMutation: Queries.getUpcomingAppointmentsLocalCacheMutation
        ) { cache in
            guard !cache.upcomingAppointments.data.lazy.map(\.fragments.appointmentFragment.id).contains(appointment.id) else { return }
            cache.upcomingAppointments.data.append(.init(fragment: appointment))
            cache.upcomingAppointments.data = cache.upcomingAppointments.data.nabla.sorted(\.fragments.appointmentFragment.scheduledAt, using: <)
        }
    }
    
    private func insertFinalizedAppointment(_ appointment: RemoteAppointment) async throws {
        try await gqlStore.updateCache(
            cacheMutation: Queries.getFinalizedAppointmentsLocalCacheMutation
        ) { cache in
            guard !cache.pastAppointments.data.lazy.map(\.fragments.appointmentFragment.id).contains(appointment.id) else { return }
            cache.pastAppointments.data.append(.init(fragment: appointment))
            cache.pastAppointments.data = cache.pastAppointments.data.nabla.sorted(\.fragments.appointmentFragment.scheduledAt, using: >)
        }
    }
    
    private func updateFilteredQueriesAfterAppointmentChange(appointment: RemoteAppointment) async throws {
        try await remove(appointmentWithId: appointment.id)
        try await insert(appointment)
    }
    
    private func remove(appointmentWithId appointmentId: UUID) async throws {
        try await gqlStore.updateCache(
            cacheMutation: Queries.getUpcomingAppointmentsLocalCacheMutation
        ) { cache in
            guard let index = cache.upcomingAppointments.data.firstIndex(where: { $0.fragments.appointmentFragment.id == appointmentId }) else { return }
            cache.upcomingAppointments.data.remove(at: index)
        }
        try await gqlStore.updateCache(
            cacheMutation: Queries.getFinalizedAppointmentsLocalCacheMutation
        ) { cache in
            guard let index = cache.pastAppointments.data.firstIndex(where: { $0.fragments.appointmentFragment.id == appointmentId }) else { return }
            cache.pastAppointments.data.remove(at: index)
        }
    }
}

private extension GQL.GetUpcomingAppointmentsLocalCacheMutation.Data.UpcomingAppointments.Datum {
    init(fragment: RemoteAppointment) {
        self.init(data: fragment.__data)
    }
}

private extension GQL.GetFinalizedAppointmentsLocalCacheMutation.Data.PastAppointments.Datum {
    init(fragment: RemoteAppointment) {
        self.init(data: fragment.__data)
    }
}
