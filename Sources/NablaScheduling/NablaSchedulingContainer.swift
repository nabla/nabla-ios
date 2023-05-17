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
    let schedulePendingAppointmentInteractor: SchedulePendingAppointmentInteractor
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
            gqlStore: gqlStore,
            logger: logger
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
        
        watchAppointmentsInteractor = WatchAppointmentsInteractorImpl(
            userRepository: coreContainer.userRepository,
            appointmentRepository: appointmentRepository
        )
        watchAppointmentInteractor = WatchAppointmentInteractorImpl(
            userRepository: coreContainer.userRepository,
            appointmentRepository: appointmentRepository
        )
        watchCategoriesInteractor = WatchCategoriesInteractorImpl(
            userRepository: coreContainer.userRepository,
            availabilitySlotRepository: availabilitySlotRepository
        )
        watchAvailabilitySlotsInteractor = WatchAvailabilitySlotsInteractorImpl(
            userRepository: coreContainer.userRepository,
            availabilitySlotRepository: availabilitySlotRepository
        )
        createPendingAppointmentInteractor = CreatePendingAppointmentInteractorImpl(
            userRepository: coreContainer.userRepository,
            appointmentRepository: appointmentRepository
        )
        schedulePendingAppointmentInteractor = SchedulePendingAppointmentInteractorImpl(
            userRepository: coreContainer.userRepository,
            appointmentRepository: appointmentRepository
        )
        cancelAppointmentInteractor = CancelAppointmentInteractorImpl(
            userRepository: coreContainer.userRepository,
            appointmentRepository: appointmentRepository
        )
        watchProviderInteractor = WatchProviderInteractorImpl(
            userRepository: coreContainer.userRepository,
            providerRepository: providerRepository
        )
        watchConsentsInteractor = WatchConsentsInteractorImpl(
            userRepository: coreContainer.userRepository,
            consentsRepository: consentsRepository
        )
        getAvailableLocationsInteractor = GetAvailableLocationsInteractorImpl(
            userRepository: coreContainer.userRepository,
            appointmentRepository: appointmentRepository
        )
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
