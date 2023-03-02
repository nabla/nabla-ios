import Foundation
import NablaCore

final class NablaSchedulingContainer {
    // MARK: - Internal
    
    let logger: Logger
    let gqlClient: GQLClient
    let gqlStore: GQLStore
    let videoCallClient: VideoCallClient?
    let addressFormatter: AddressFormatter
    let universalLinkGenerator: CompositeUniversalLinkGenerator
    let watchAppointmentsInteractor: WatchAppointmentsInteractor
    let watchAppointmentInteractor: WatchAppointmentInteractor
    let watchCategoriesInteractor: WatchCategoriesInteractor
    let watchAvailabilitySlotsInteractor: WatchAvailabilitySlotsInteractor
    let createPendingAppointmentInteractor: CreatePendingAppointmentInteractor
    let schedulePendingAppointmentInteractor: SchedulingPendingAppointmentInteractor
    let cancelAppointmentInteractor: CancelAppointmentInteractor
    let watchProviderInteractor: WatchProviderInteractor
    let watchConsentsInteractor: WatchConsentsInteractor
    let getAvailableLocationsInteractor: GetAvailableLocationsInteractor

    // MARK: Initializer
    
    init(
        coreContainer: CoreContainer
    ) {
        self.coreContainer = coreContainer
        
        logger = coreContainer.logger
        gqlClient = coreContainer.gqlClient
        gqlStore = coreContainer.gqlStore
        videoCallClient = coreContainer.videoCallClient
        
        addressFormatter = FoundationAddressFormatter()
        
        universalLinkGenerator = CompositeUniversalLinkGenerator(generators: [
            GoogleMapsUniversalLinkGenerator(allowOpeningInWebBrowser: false, formatter: addressFormatter),
            AppleMapsUniversalLinkGenerator(formatter: addressFormatter),
        ])
        
        consentsRemoteDataSource = ConsentsRemoteDataSourceImpl(
            gqlClient: gqlClient
        )
        consentsRepository = ConsentsRepositoryImpl(
            remoteDataSource: consentsRemoteDataSource
        )
        
        providerRemoteDataSource = ProviderRemoteDataSourceImpl(
            gqlClient: gqlClient
        )
        providerRepository = ProviderRepositoryImpl(
            remoteDataSource: providerRemoteDataSource
        )
        
        appointmentRemoteDataSource = AppointmentRemoteDataSourceImpl(
            gqlClient: gqlClient,
            gqlStore: gqlStore
        )
        appointmentRepository = AppointmentRepositoryImpl(
            logger: logger,
            remoteDataSource: appointmentRemoteDataSource
        )
        
        availabilitySlotRemoteDataSource = AvailabilitySlotRemoteDataSourceImpl(
            gqlClient: gqlClient,
            gqlStore: gqlStore
        )
        availabilitySlotRepository = AvailabilitySlotRepositoryImpl(remoteDataSource: availabilitySlotRemoteDataSource)
        
        watchAppointmentsInteractor = WatchAppointmentsInteractorImpl(repository: appointmentRepository)
        watchAppointmentInteractor = WatchAppointmentInteractorImpl(repository: appointmentRepository)
        watchCategoriesInteractor = WatchCategoriesInteractorImpl(repository: availabilitySlotRepository)
        watchAvailabilitySlotsInteractor = WatchAvailabilitySlotsInteractorImpl(repository: availabilitySlotRepository)
        createPendingAppointmentInteractor = CreatePendingAppointmentInteractorImpl(repository: appointmentRepository)
        schedulePendingAppointmentInteractor = SchedulingPendingAppointmentInteractorImpl(repository: appointmentRepository)
        cancelAppointmentInteractor = CancelAppointmentInteractorImpl(repository: appointmentRepository)
        watchProviderInteractor = WatchProviderInteractorImpl(repository: providerRepository)
        watchConsentsInteractor = WatchConsentsInteractorImpl(repository: consentsRepository)
        getAvailableLocationsInteractor = GetAvailableLocationsInteractorImpl(repository: appointmentRepository)
    }
    
    // MARK: - Private
    
    private let coreContainer: CoreContainer
    private let availabilitySlotRepository: AvailabilitySlotRepository
    private let availabilitySlotRemoteDataSource: AvailabilitySlotRemoteDataSource
    private let appointmentRepository: AppointmentRepository
    private let appointmentRemoteDataSource: AppointmentRemoteDataSource
    private let providerRepository: ProviderRepository
    private let providerRemoteDataSource: ProviderRemoteDataSource
    private let consentsRepository: ConsentsRepository
    private let consentsRemoteDataSource: ConsentsRemoteDataSource
}
