import Foundation
import NablaCore

final class NablaSchedulingContainer {
    // MARK: - Internal
    
    var logger: Logger { coreContainer.logger }
    
    var gqlClient: AsyncGQLClient {
        coreContainer.gqlClient
    }
    
    var gqlStore: AsyncGQLStore {
        coreContainer.gqlStore
    }
    
    var videoCallClient: VideoCallClient? {
        coreContainer.videoCallClient
    }
    
    private(set) lazy var watchAppointmentsInteractor: WatchAppointmentsInteractor = WatchAppointmentsInteractorImpl(repository: appointmentRepository)
    private(set) lazy var watchCategoriesInteractor: WatchCategoriesInteractor = WatchCategoriesInteractorImpl(repository: availabilitySlotRepository)
    private(set) lazy var watchAvailabilitySlotsInteractor: WatchAvailabilitySlotsInteractor = WatchAvailabilitySlotsInteractorImpl(repository: availabilitySlotRepository)
    private(set) lazy var scheduleAppointmentInteractor: ScheduleAppointmentInteractor = ScheduleAppointmentInteractorImpl(repository: appointmentRepository)
    private(set) lazy var cancelAppointmentInteractor: CancelAppointmentInteractor = CancelAppointmentInteractorImpl(repository: appointmentRepository)
    private(set) lazy var watchProviderInteractor: WatchProviderInteractor = WatchProviderInteractorImpl(repository: providerRepository)
    private(set) lazy var fetchConsentsInteractor: FetchConcentsInteractor = FetchConsentsInteractorImpl(repository: consentsRepository)

    // MARK: Initializer
    
    init(
        coreContainer: CoreContainer
    ) {
        self.coreContainer = coreContainer
    }
    
    // MARK: - Private
    
    private let coreContainer: CoreContainer
    
    private lazy var availabilitySlotRepository: AvailabilitySlotRepository = AvailabilitySlotRepositoryImpl(remoteDataSource: availabilitySlotRemoteDataSource)
    
    private lazy var availabilitySlotRemoteDataSource: AvailabilitySlotRemoteDataSource = AvailabilitySlotRemoteDataSourceImpl(
        gqlClient: gqlClient,
        gqlStore: gqlStore
    )
    
    private lazy var appointmentRepository: AppointmentRepository = AppointmentRepositoryImpl(
        logger: logger,
        remoteDataSource: appointmentRemoteDataSource
    )
    
    private lazy var appointmentRemoteDataSource: AppointmentRemoteDataSource = AppointmentRemoteDataSourceImpl(
        gqlClient: gqlClient,
        gqlStore: gqlStore
    )

    private lazy var providerRepository: ProviderRepository = ProviderRepositoryImpl(
        remoteDataSource: providerRemoteDataSource
    )

    private lazy var providerRemoteDataSource: ProviderRemoteDataSource = ProviderRemoteDataSourceImpl(
        gqlClient: gqlClient
    )
    
    private lazy var consentsRepository: ConsentsRepository = ConsentsRepositoryImpl(
        remoteDataSource: consentsRemoteDataSource
    )
    
    private lazy var consentsRemoteDataSource: ConsentsRemoteDataSource = ConsentsRemoteDataSourceImpl(
        gqlClient: gqlClient
    )
}
