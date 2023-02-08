import Combine
import Foundation
import NablaCore

public final class NablaSchedulingClient: SchedulingClient {
    // MARK: - Public
    
    public var universalLinkGenerators: [UniversalLinkGenerator] {
        get { container.universalLinkGenerator.generators }
        set { container.universalLinkGenerator.generators = newValue }
    }
    
    // MARK: - Internal
    
    func watchAppointments(state: Appointment.State) -> AnyPublisher<AnyResponse<PaginatedList<Appointment>, NablaError>, NablaError> {
        container.watchAppointmentsInteractor.execute(state: state)
    }
    
    func watchAppointment(id: UUID) -> AnyPublisher<Appointment, NablaError> {
        container.watchAppointmentInteractor.execute(id: id)
    }
    
    func watchCategories() -> AnyPublisher<[Category], NablaError> {
        container.watchCategoriesInteractor.execute()
    }
    
    func watchAvailabilitySlots(forCategoryWithId categoryId: UUID, location: LocationType) -> AnyPublisher<PaginatedList<AvailabilitySlot>, NablaError> {
        container.watchAvailabilitySlotsInteractor.execute(categoryId: categoryId, location: location)
    }

    func watchProvider(id: UUID) -> AnyPublisher<Provider, NablaError> {
        container.watchProviderInteractor.execute(providerId: id)
    }
    
    /// - Throws: ``NablaError``
    func scheduleAppointment(
        location: LocationType,
        categoryId: UUID,
        providerId: UUID,
        date: Date
    ) async throws -> Appointment {
        try await container.scheduleAppointmentInteractor.execute(
            location: location,
            categoryId: categoryId,
            providerId: providerId,
            date: date
        )
    }
    
    /// - Throws: ``NablaError``
    func cancelAppointment(withId appointmentId: UUID) async throws {
        try await container.cancelAppointmentInteractor.execute(appointmentId: appointmentId)
    }
    
    func watchConsents(location: LocationType) -> AnyPublisher<Consents, NablaError> {
        container.watchConsentsInteractor.execute(location: location)
    }
    
    /// - Throws: ``NablaError``
    func getAvailableLocations() async throws -> Set<LocationType> {
        try await container.getAvailableLocationsInteractor.execute()
    }
    
    // MARK: Initializer
    
    public init(
        container: CoreContainer
    ) {
        self.container = NablaSchedulingContainer(
            coreContainer: container
        )
    }
    
    // MARK: - Internal
    
    let container: NablaSchedulingContainer
        
    // MARK: - Private
}
