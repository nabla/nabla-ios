import Combine
import Foundation
import NablaCore

final class AppointmentRepositoryImpl: AppointmentRepository {
    // MARK: - Internal
    
    func watchAppointments(state: Appointment.State) -> AnyPublisher<PaginatedList<Appointment>, NablaError> {
        let transformer = RemoteAppointmentTransformer(logger: logger)
        return remoteDataSource.watchAppointments(state: transformer.transform(state))
            .map { remote in
                PaginatedList<Appointment>(
                    data: remote.data.map(transformer.transform),
                    hasMore: remote.hasMore,
                    loadMore: remote.loadMore
                )
            }
            .mapError(GQLErrorTransformer.transform(gqlError:))
            .eraseToAnyPublisher()
    }
    
    /// - Throws: ``NablaError``
    func scheduleAppointment(location: LocationType, categoryId: UUID, providerId: UUID, date: Date) async throws -> Appointment {
        do {
            let appointment = try await remoteDataSource.scheduleAppointment(
                isPhysical: location == .physical,
                categoryId: categoryId,
                providerId: providerId,
                date: date
            )
            let transformer = RemoteAppointmentTransformer(logger: logger)
            return transformer.transform(appointment)
        } catch let gqlError as GQLError {
            throw GQLErrorTransformer.transform(gqlError: gqlError)
        } catch {
            throw InternalError(underlyingError: error)
        }
    }
    
    /// - Throws: ``NablaError``
    func cancelAppointment(withId appointmentId: UUID) async throws {
        do {
            try await remoteDataSource.cancelAppointment(withId: appointmentId)
        } catch let gqlError as GQLError {
            throw GQLErrorTransformer.transform(gqlError: gqlError)
        } catch {
            throw InternalError(underlyingError: error)
        }
    }
    
    /// - Throws: ``NablaError``
    func getAvailableAppointmentLocations() async throws -> Set<LocationType> {
        do {
            let response = try await remoteDataSource.getAvailableLocations()
            var availableLocations = Set<LocationType>()
            if response.hasPhysicalAvailabilities {
                availableLocations.insert(.physical)
            }
            if response.hasRemoteAvailabilities {
                availableLocations.insert(.remote)
            }
            return availableLocations
        } catch let gqlError as GQLError {
            throw GQLErrorTransformer.transform(gqlError: gqlError)
        } catch {
            throw InternalError(underlyingError: error)
        }
    }
    
    // MARK: Init
    
    init(
        logger: Logger,
        remoteDataSource: AppointmentRemoteDataSource
    ) {
        self.logger = logger
        self.remoteDataSource = remoteDataSource
        subscribeToAppointmentsEvents()
    }
    
    // MARK: - Private
    
    private let logger: Logger
    private let remoteDataSource: AppointmentRemoteDataSource
    
    private var appointmentsEventsSubscriber: AnyCancellable?
    
    private func subscribeToAppointmentsEvents() {
        appointmentsEventsSubscriber = remoteDataSource
            .subscribeToAppointmentsEvents()
            .nabla.sink()
    }
}
