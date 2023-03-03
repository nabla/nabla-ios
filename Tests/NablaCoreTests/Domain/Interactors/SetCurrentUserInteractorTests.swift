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
    
        environment.given(.version(getter: "test"))
        
        Matcher.default.register(User?.self, match: { $0?.id == $1?.id })
        Matcher.default.register(SentryConfiguration.self, match: { $0.dsn == $1.dsn && $0.env == $1.env })
    }
    
    func testWithoutAnyCurrentUser() throws {
        // GIVEN
        let userId = "userId"
        let sentry = SentryConfiguration(dsn: "dsn", env: "env")
        userRepository.given(.getCurrentUser(willReturn: nil))
        let expectation = givenUpdateOrRegisterDevice(willReturn: sentry)
        // WHEN
        try sut.execute(userId: userId)
        // THEN
        wait(for: [expectation], timeout: 1)
        authenticator.verify(.authenticate(userId: .value(userId)))
        userRepository.verify(.setCurrentUser(.value(User(id: userId))))
        deviceRepository.verify(.updateOrRegisterDevice(userId: .value(userId), withModules: .any))
        deviceRepository.verify(.setSentryConfiguration(.value(sentry)))
    }
    
    func testWithTheSamePersistedCurrentUser() throws {
        // GIVEN
        let userId = "userId"
        let sentry = SentryConfiguration(dsn: "dsn", env: "env")
        userRepository.given(.getCurrentUser(willReturn: User(id: "userId")))
        let expectation = givenUpdateOrRegisterDevice(willReturn: sentry)
        // WHEN
        try sut.execute(userId: userId)
        // THEN
        wait(for: [expectation], timeout: 1)
        authenticator.verify(.authenticate(userId: .value(userId)))
        userRepository.verify(.setCurrentUser(.value(User(id: userId))))
        deviceRepository.verify(.updateOrRegisterDevice(userId: .value(userId), withModules: .any))
        deviceRepository.verify(.setSentryConfiguration(.value(sentry)))
    }
    
    func testWithTheSamePersistedCurrentUserTwice() throws {
        // GIVEN
        let userId = "userId"
        let sentry = SentryConfiguration(dsn: "dsn", env: "env")
        userRepository.given(.getCurrentUser(willReturn: User(id: "userId")))
        let expectation = givenUpdateOrRegisterDevice(willReturn: sentry)
        // WHEN
        try sut.execute(userId: userId)
        // THEN
        wait(for: [expectation], timeout: 1)
        authenticator.verify(.authenticate(userId: .any), count: 1)
        userRepository.verify(.setCurrentUser(.any), count: 1)
        deviceRepository.verify(.updateOrRegisterDevice(userId: .any, withModules: .any), count: 1)
        deviceRepository.verify(.setSentryConfiguration(.value(sentry)), count: 1)
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
    
    private func givenUpdateOrRegisterDevice(willReturn results: SentryConfiguration?...) -> XCTestExpectation {
        var iterator = 0
        let updateOrRegisterDeviceWasCalled = expectation(description: "")
        updateOrRegisterDeviceWasCalled.expectedFulfillmentCount = results.count
        deviceRepository.given(.updateOrRegisterDevice(userId: .any, withModules: .any, willProduce: { stubber in
            updateOrRegisterDeviceWasCalled.fulfill()
            if iterator <= results.count {
                stubber.return(results[iterator])
            } else {
                stubber.return(nil)
            }
            iterator += 1
        }))
        return updateOrRegisterDeviceWasCalled
    }
}
