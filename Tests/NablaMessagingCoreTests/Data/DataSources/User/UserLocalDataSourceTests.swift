@testable import NablaMessagingCore
import SwiftyMocky
import XCTest

class UserLocalDataSourceTests: XCTestCase {
    private var logger: LoggerMock!
    private var store: KeyValueStoreMock!
    
    private var sut: UserLocalDataSourceImpl!
    
    override func setUp() {
        super.setUp()
        logger = LoggerMock()
        store = KeyValueStoreMock()
        sut = UserLocalDataSourceImpl(logger: logger, store: store)
        
        Matcher.default.register(LocalUser?.self) { lhs, rhs in
            lhs?.id == rhs?.id
        }
    }
    
    // MARK: Constants.currentUserStoreKey

    func testCurrentUserKeyIsUnchanged() {
        // GIVEN
        // WHEN
        _ = sut.getCurrentUser()
        sut.setCurrentUser(nil)
        // THEN
        Verify(store, .get(forKey: .value("currentUser")))
        Verify(store, .set(.any(LocalUser?.self), forKey: .value("currentUser")))
    }
    
    // MARK: getCurrentUser()
    
    func testReturnsStoredUserIfExist() {
        // GIVEN
        let user = LocalUser.mock()
        Given(store, .get(forKey: .any, willReturn: user))
        // WHEN
        let result = sut.getCurrentUser()
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, user.id)
    }
    
    func testReturnsNilIfNoUserStored() {
        // GIVEN
        Given(store, .get(forKey: .any, willReturn: nil as LocalUser?))
        // WHEN
        let result = sut.getCurrentUser()
        // THEN
        XCTAssertNil(result)
    }
    
    func testReturnsNilAndLogsErrorWhenStoreThrows() {
        // GIVEN
        Given(store, .get(forKey: .any, willThrow: TestError.somethingFailed))
        // WHEN
        let result = sut.getCurrentUser()
        // THEN
        XCTAssertNil(result)
        Verify(logger, .error(message: .any))
    }
    
    // MARK: setCurrentUser(_:)
    
    func testStoresCurrentUser() {
        // GIVEN
        let user = LocalUser.mock()
        // WHEN
        sut.setCurrentUser(user)
        // THEN
        Verify(store, .set(.value(user), forKey: .any))
    }
    
    func testStoresNil() {
        // GIVEN
        // WHEN
        sut.setCurrentUser(nil)
        // THEN
        Verify(store, .set(.value(nil as LocalUser?), forKey: .any))
    }
    
    func testLogsErrorWhenStoreThrows() {
        // GIVEN
        Given(store, .set(.any(LocalUser?.self), forKey: .any, willThrow: TestError.somethingFailed))
        // WHEN
        sut.setCurrentUser(nil)
        // THEN
        Verify(logger, .error(message: .any))
    }
}
              
private enum TestError: Error {
    case somethingFailed
}
