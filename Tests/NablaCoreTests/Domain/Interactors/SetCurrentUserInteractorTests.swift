@testable import NablaCore
import NablaCoreTestsUtils
import SwiftyMocky
import XCTest

final class SetCurrentUserInteractorTests: XCTestCase {
    private var sut: SetCurrentUserInteractorImpl!
    
    private var userRepository: UserRepositoryMock!
    private var logger: LoggerMock!

    override func setUp() {
        super.setUp()
        
        userRepository = .init()
        logger = .init()
        
        sut = .init(
            userRepository: userRepository,
            logger: logger
        )
        
        Matcher.default.register(User?.self, match: { $0?.id == $1?.id })
        Matcher.default.register(SentryConfiguration.self, match: { $0.dsn == $1.dsn && $0.env == $1.env })
    }
    
    func testWithoutAnyCurrentUser() throws {
        // GIVEN
        let userId = "userId"
        userRepository.given(.getCurrentUser(willReturn: nil))
        // WHEN
        try sut.execute(userId: userId)
        // THEN
        userRepository.verify(.setCurrentUser(.value(User(id: userId))))
    }
    
    func testWithTheSameCurrentUser() throws {
        // GIVEN
        let userId = "userId"
        userRepository.given(.getCurrentUser(willReturn: User(id: userId)))
        // WHEN
        try sut.execute(userId: userId)
        // THEN
        userRepository.verify(.setCurrentUser(.any), count: 0)
    }
    
    func testWithSomeOtherCurrentUser() throws {
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
        userRepository.verify(.setCurrentUser(.any), count: 0)
    }
}
