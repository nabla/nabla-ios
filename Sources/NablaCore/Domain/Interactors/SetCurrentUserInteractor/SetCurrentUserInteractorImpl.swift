import Foundation

final class SetCurrentUserInteractorImpl: SetCurrentUserInteractor {
    // MARK: - Internal
    
    func execute(userId: String) throws {
        guard userId != currentInMemoryUserId else {
            logger.info(message: "Setting the same current user again. Ignoring.")
            return
        }
        
        if let previousUser = currentPersistedUser, previousUser.id != userId {
            logger.error(message: "Trying to authenticate a new user, should clear previous one first by calling `clearCurrentUser`.")
            throw CurrentUserAlreadySetError()
        }
        logger.info(message: "Setting a new current user.")
        currentPersistedUser = User(id: userId)
        authenticator.authenticate(userId: userId)
        
        Task {
            do {
                let sentry = try await deviceRepository.updateOrRegisterDevice(userId: userId, withModules: modules)
                if let sentry = sentry {
                    deviceRepository.setSentryConfiguration(sentry)
                    errorReporter.enable(dsn: sentry.dsn, env: sentry.env, sdkVersion: environment.version)
                }
            } catch {
                logger.warning(message: "Failed to register device", error: error, extra: ["user": userId])
            }
        }
    }
    
    // MARK: Init
    
    init(
        environment: Environment,
        authenticator: Authenticator,
        userRepository: UserRepository,
        deviceRepository: DeviceRepository,
        errorReport: ErrorReporter,
        logger: Logger,
        modules: [Module]
    ) {
        self.environment = environment
        self.authenticator = authenticator
        self.userRepository = userRepository
        self.deviceRepository = deviceRepository
        errorReporter = errorReport
        self.logger = logger
        self.modules = modules
    }
    
    // MARK: - Private
    
    private let environment: Environment
    private let authenticator: Authenticator
    private let userRepository: UserRepository
    private let deviceRepository: DeviceRepository
    private let errorReporter: ErrorReporter
    private let logger: Logger
    private let modules: [Module]
    
    /// We differentiate the in-memory user from the persisted one.
    /// This is because on app start, the persisted user might exist but we should not take any action before
    /// `execute(userId:)` is called and the in-memory user is set.
    private var currentInMemoryUserId: String? {
        authenticator.currentUserId
    }

    private var currentPersistedUser: User? {
        get { userRepository.getCurrentUser() }
        set { userRepository.setCurrentUser(newValue) }
    }
}
