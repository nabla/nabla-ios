@testable import NablaCore
import NablaCoreTestsUtils
import SwiftyMocky
import XCTest

final class SetCurrentUserInteractorTests: XCTestCase {
    private var sut: SetCurrentUserInteractorImpl!
    
    private var environment: EnvironmentMock!
    private var authenticator: AuthenticatorMock!
    private var userRepository: UserRepositoryMock!
    private var deviceRepository: DeviceRepositoryMock!
    private var errorReporter: ErrorReporterMock!
    private var logger: LoggerMock!

    override func setUp() {
        super.setUp()
        
        environment = .init()
        authenticator = .init()
        userRepository = .init()
        deviceRepository = .init()
        errorReporter = .init()
        logger = .init()
        
        sut = .init(
            environment: environment,
            authenticator: authenticator,
            userRepository: userRepository,
            deviceRepository: deviceRepository,
            errorReport: errorReporter,
            logger: logger,
            modules: []
        )
        
        Matcher.default.register(User?.self, match: { $0?.id == $1?.id })
    }
    
    func testWithoutAnyCurrentUser() throws {
        // GIVEN
        let userId = "userId"
        userRepository.given(.getCurrentUser(willReturn: nil))
        // WHEN
        try sut.execute(userId: userId)
        // THEN
        authenticator.verify(.authenticate(userId: .value(userId)))
        userRepository.verify(.setCurrentUser(.value(User(id: userId))))
        deviceRepository.verify(.updateOrRegisterDevice(userId: .value(userId), withModules: .any))
    }
    
    func testWithTheSamePersistedCurrentUser() throws {
        // GIVEN
        let userId = "userId"
        userRepository.given(.getCurrentUser(willReturn: User(id: "userId")))
        // WHEN
        try sut.execute(userId: userId)
        // THEN
        authenticator.verify(.authenticate(userId: .value(userId)))
        userRepository.verify(.setCurrentUser(.value(User(id: userId))))
        deviceRepository.verify(.updateOrRegisterDevice(userId: .value(userId), withModules: .any))
    }
    
    func testWithTheSamePersistedCurrentUserTwice() throws {
        // GIVEN
        let userId = "userId"
        userRepository.given(.getCurrentUser(willReturn: User(id: "userId")))
        // WHEN
        try sut.execute(userId: userId)
        try sut.execute(userId: userId)
        // THEN
        authenticator.verify(.authenticate(userId: .any), count: 1)
        userRepository.verify(.setCurrentUser(.any), count: 1)
        deviceRepository.verify(.updateOrRegisterDevice(userId: .any, withModules: .any), count: 1)
    }
    
    func testWithSomeOtherPersistedCurrentUser() throws {
        // GIVEN
        let userId = "newUserId"
        userRepository.given(.getCurrentUser(willReturn: User(id: "persistedUserId")))
        // WHEN
        do {
            try sut.execute(userId: userId)
            XCTFail("`execute` should throw")
        } catch {
            XCTAssert(error is CurrentUserAlreadySetError)
        }
        // THEN
        authenticator.verify(.authenticate(userId: .any), count: 0)
        userRepository.verify(.setCurrentUser(.any), count: 0)
        deviceRepository.verify(.updateOrRegisterDevice(userId: .any, withModules: .any), count: 0)
    }
}
