import Foundation
import NablaCore
import Combine

final class AppointmentRepositoryImpl: AppointmentRepository {
    // MARK: - Internal
    
    func watchAppointments(state: Appointment.State) -> AnyPublisher<PaginatedList<Appointment>, NablaError> {
        remoteDataSource.watchAppointments(state: RemoteAppointmentTransformer.transform(state))
            .map { remote in
                PaginatedList<Appointment>(
                    data: remote.data.map(RemoteAppointmentTransformer.transform),
                    hasMore: remote.hasMore,
                    loadMore: remote.loadMore
                )
            }
            .mapError(GQLErrorTransformer.transform(gqlError:))
            .eraseToAnyPublisher()
    }
    
    /// Throws `NablaError`
    func scheduleAppointment(categoryId: UUID, providerId: UUID, date: Date) async throws -> Appointment {
        do {
            let appointment = try await remoteDataSource.scheduleAppointment(categoryId: categoryId, providerId: providerId, date: date)
            return RemoteAppointmentTransformer.transform(appointment)
        } catch let gqlError as GQLError {
            throw GQLErrorTransformer.transform(gqlError: gqlError)
        } catch {
            throw InternalError(underlyingError: error)
        }
    }
    
    /// Throws `NablaError`
    func cancelAppointment(withId appointmentId: UUID) async throws {
        do {
            try await remoteDataSource.cancelAppointment(withId: appointmentId)
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
            .nabla.sink(receiveError: { [weak self, logger] error in
                logger.error(message: "Appointments subscription failed", extra: ["reason": error])
                self?.subscribeToAppointmentsEvents()
            })
    }
}
