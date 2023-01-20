import Combine
import Foundation
import NablaCore

final class AppointmentRemoteDataSourceImpl: AppointmentRemoteDataSource {
    // MARK: Internal
    
    func watchAppointments(state: RemoteAppointment.State.Enum) -> AnyPublisher<PaginatedList<RemoteAppointment>, GQLError> {
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
    func scheduleAppointment(isPhysical: Bool, categoryId: UUID, providerId: UUID, date: Date) async throws -> RemoteAppointment {
        let response = try await gqlClient.perform(
            mutation: GQL.ScheduleAppointmentMutation(
                isPhysical: isPhysical,
                categoryId: categoryId,
                providerId: providerId,
                timeSlot: date,
                timeZone: TimeZone.current.identifier
            )
        )
        let fragment = response.scheduleAppointmentV2.appointment.fragments.appointmentFragment
        try await insert(fragment)
        return fragment
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
        gqlStore: GQLStore
    ) {
        self.gqlClient = gqlClient
        self.gqlStore = gqlStore
    }
    
    // MARK: - Private
    
    private let gqlClient: GQLClient
    private let gqlStore: GQLStore
    
    private enum Queries {
        // TODO: Refactor backend to use the same query for both and avoid code duplicate
        static var getUpcomingAppointmentsRootQuery: GQL.GetUpcomingAppointmentsQuery {
            getUpcomingAppointmentsQuery(cursor: nil)
        }

        static func getUpcomingAppointmentsQuery(cursor: String?) -> GQL.GetUpcomingAppointmentsQuery {
            GQL.GetUpcomingAppointmentsQuery(page: .init(cursor: cursor, numberOfItems: 50))
        }

        static var getFinalizedAppointmentsRootQuery: GQL.GetFinalizedAppointmentsQuery {
            getFinalizedAppointmentsQuery(cursor: nil)
        }

        static func getFinalizedAppointmentsQuery(cursor: String?) -> GQL.GetFinalizedAppointmentsQuery {
            GQL.GetFinalizedAppointmentsQuery(page: .init(cursor: cursor, numberOfItems: 50))
        }
    }
    
    private func watchUpcomingAppointments() -> AnyPublisher<PaginatedList<RemoteAppointment>, GQLError> {
        gqlClient.watch(
            query: Queries.getUpcomingAppointmentsRootQuery,
            policy: .returnCacheDataAndFetch
        )
        .map { response -> PaginatedList<RemoteAppointment> in
            let data = response.upcomingAppointments.data.map(\.fragments.appointmentFragment)
                
            var fetchMore: (() async throws -> Void)?
            if let cursor = response.upcomingAppointments.nextCursor {
                fetchMore = { [weak self] in
                    try await self?.fetchMoreUpcomingAppointments(cursor: cursor)
                }
            }

            return PaginatedList<RemoteAppointment>(
                data: data,
                hasMore: response.upcomingAppointments.hasMore,
                loadMore: fetchMore
            )
        }
        .eraseToAnyPublisher()
    }
    
    private func watchFinalizedAppointments() -> AnyPublisher<PaginatedList<RemoteAppointment>, GQLError> {
        gqlClient.watch(
            query: Queries.getFinalizedAppointmentsRootQuery,
            policy: .returnCacheDataAndFetch
        )
        .map { response -> PaginatedList<RemoteAppointment> in
            let data = response.pastAppointments.data.map(\.fragments.appointmentFragment)
                
            var fetchMore: (() async throws -> Void)?
            if let cursor = response.pastAppointments.nextCursor {
                fetchMore = { [weak self] in
                    try await self?.fetchMoreFinalizedAppointments(cursor: cursor)
                }
            }

            return PaginatedList<RemoteAppointment>(
                data: data,
                hasMore: response.pastAppointments.hasMore,
                loadMore: fetchMore
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
            for: Queries.getUpcomingAppointmentsRootQuery,
            onlyIfExists: true,
            body: { (cache: inout GQL.GetUpcomingAppointmentsQuery.Data) in
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
            for: Queries.getFinalizedAppointmentsRootQuery,
            onlyIfExists: true,
            body: { (cache: inout GQL.GetFinalizedAppointmentsQuery.Data) in
                Self.append(response, to: &cache)
            }
        )
    }
    
    private static func append(_ response: GQL.GetUpcomingAppointmentsQuery.Data, to cache: inout GQL.GetUpcomingAppointmentsQuery.Data) {
        cache.upcomingAppointments.hasMore = response.upcomingAppointments.hasMore
        cache.upcomingAppointments.nextCursor = response.upcomingAppointments.nextCursor
        
        let existingAppointments = Set(cache.upcomingAppointments.data.map(\.fragments.appointmentFragment.id))
        
        for newAppointment in response.upcomingAppointments.data {
            guard !existingAppointments.contains(newAppointment.fragments.appointmentFragment.id) else { continue }
            cache.upcomingAppointments.data.append(newAppointment)
            cache.upcomingAppointments.data = cache.upcomingAppointments.data.nabla.sorted(\.fragments.appointmentFragment.scheduledAt, using: <)
        }
    }
    
    private static func append(_ response: GQL.GetFinalizedAppointmentsQuery.Data, to cache: inout GQL.GetFinalizedAppointmentsQuery.Data) {
        cache.pastAppointments.hasMore = response.pastAppointments.hasMore
        cache.pastAppointments.nextCursor = response.pastAppointments.nextCursor
        
        let existingAppointments = Set(cache.pastAppointments.data.map(\.fragments.appointmentFragment.id))
        
        for newAppointment in response.pastAppointments.data {
            guard !existingAppointments.contains(newAppointment.fragments.appointmentFragment.id) else { continue }
            cache.pastAppointments.data.append(newAppointment)
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
        }
    }
    
    private func insert(_ appointment: RemoteAppointment) async throws {
        switch appointment.state.asEnum {
        case .upcoming:
            try await gqlStore.updateCache(
                for: Queries.getUpcomingAppointmentsRootQuery,
                onlyIfExists: true
            ) { (cache: inout GQL.GetUpcomingAppointmentsQuery.Data) in
                guard !cache.upcomingAppointments.data.lazy.map(\.fragments.appointmentFragment.id).contains(appointment.id) else { return }
                cache.upcomingAppointments.data.append(.init(fragment: appointment))
                cache.upcomingAppointments.data = cache.upcomingAppointments.data.nabla.sorted(\.fragments.appointmentFragment.scheduledAt, using: <)
            }
        case .finalized:
            try await gqlStore.updateCache(
                for: Queries.getFinalizedAppointmentsRootQuery,
                onlyIfExists: true
            ) { (cache: inout GQL.GetFinalizedAppointmentsQuery.Data) in
                guard !cache.pastAppointments.data.lazy.map(\.fragments.appointmentFragment.id).contains(appointment.id) else { return }
                cache.pastAppointments.data.append(.init(fragment: appointment))
                cache.pastAppointments.data = cache.pastAppointments.data.nabla.sorted(\.fragments.appointmentFragment.scheduledAt, using: >)
            }
        }
    }
    
    private func updateFilteredQueriesAfterAppointmentChange(appointment: RemoteAppointment) async throws {
        try await remove(appointmentWithId: appointment.id)
        try await insert(appointment)
    }
    
    private func remove(appointmentWithId appointmentId: UUID) async throws {
        try await gqlStore.updateCache(
            for: Queries.getUpcomingAppointmentsRootQuery,
            onlyIfExists: true
        ) { (cache: inout GQL.GetUpcomingAppointmentsQuery.Data) in
            guard let index = cache.upcomingAppointments.data.firstIndex(where: { $0.fragments.appointmentFragment.id == appointmentId }) else { return }
            cache.upcomingAppointments.data.remove(at: index)
        }
        try await gqlStore.updateCache(
            for: Queries.getFinalizedAppointmentsRootQuery,
            onlyIfExists: true
        ) { (cache: inout GQL.GetFinalizedAppointmentsQuery.Data) in
            guard let index = cache.pastAppointments.data.firstIndex(where: { $0.fragments.appointmentFragment.id == appointmentId }) else { return }
            cache.pastAppointments.data.remove(at: index)
        }
    }
}

private extension GQL.GetUpcomingAppointmentsQuery.Data.UpcomingAppointment.Datum {
    init(fragment: RemoteAppointment) {
        self.init(unsafeResultMap: fragment.resultMap)
    }
}

private extension GQL.GetFinalizedAppointmentsQuery.Data.PastAppointment.Datum {
    init(fragment: RemoteAppointment) {
        self.init(unsafeResultMap: fragment.resultMap)
    }
}
