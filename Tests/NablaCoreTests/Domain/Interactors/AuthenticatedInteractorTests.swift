import Combine
@testable import NablaCore
import NablaCoreTestsUtils
import XCTest

final class AuthenticatedInteractorTests: XCTestCase {
    private var sut: DummyInteractor!
    
    private var userRepository: UserRepositoryMock!

    override func setUp() {
        super.setUp()
        
        userRepository = .init()
        
        sut = .init(userRepository: userRepository)
    }

    func testExecuteAsyncWhileAuthenticated() async throws {
        // GIVEN
        userRepository.given(.getCurrentUser(willReturn: User(id: .init())))
        // WHEN
        let result = try await sut.executeAsync()
        // THEN
        XCTAssertEqual("Hello world!", result)
    }
    
    func testExecuteAsyncWhileNotAuthenticated() async throws {
        // GIVEN
        userRepository.given(.getCurrentUser(willReturn: nil))
        // WHEN
        do {
            _ = try await sut.executeAsync()
            XCTFail("Should throw")
        } catch {
            // THEN
            XCTAssert(error is UserIdNotSetError)
        }
    }
    
    func testExecutePublisherWhileAuthenticated() async throws {
        // GIVEN
        let currentUser = CurrentValueSubject<User?, Never>(User(id: .init()))
        userRepository.given(.watchCurrentUser(willReturn: currentUser.eraseToAnyPublisher()))
        let didReceiveValue = expectation(description: "Did receive error")
        // WHEN
        let cancellable = sut.executePublisher()
            .sink { completion in
                XCTFail("Should not receive \(completion)")
            } receiveValue: { value in
                XCTAssertEqual("Hello world!", value)
                didReceiveValue.fulfill()
            }
        // THEN
        wait(for: [didReceiveValue], timeout: 0.5)
        XCTAssertNotNil(cancellable)
    }
    
    func testExecutePublisherWhileNotAuthenticated() async throws {
        // GIVEN
        let currentUser = CurrentValueSubject<User?, Never>(nil)
        userRepository.given(.watchCurrentUser(willReturn: currentUser.eraseToAnyPublisher()))
        let didReceiveError = expectation(description: "Did receive error")
        // WHEN
        let cancellable = sut.executePublisher()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail("Should receive failure")
                case let .failure(error):
                    XCTAssert(error is UserIdNotSetError)
                    didReceiveError.fulfill()
                }
            } receiveValue: { _ in
                XCTFail("Should not receive value")
            }
        // THEN
        wait(for: [didReceiveError], timeout: 0.5)
        XCTAssertNotNil(cancellable)
    }
    
    func testExecutePublisherWithTransientAuthentication() async throws {
        // GIVEN
        let currentUser = CurrentValueSubject<User?, Never>(User(id: .init()))
        userRepository.given(.watchCurrentUser(willReturn: currentUser.eraseToAnyPublisher()))
        let didReceiveValue = expectation(description: "Did receive error")
        let didReceiveFailure = expectation(description: "Did receive failure")
        let cancellable = sut.executePublisher()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail("Should receive failure")
                case let .failure(error):
                    XCTAssert(error is UserIdNotSetError)
                    didReceiveFailure.fulfill()
                }
            } receiveValue: { value in
                XCTAssertEqual("Hello world!", value)
                didReceiveValue.fulfill()
            }
        // WHEN
        currentUser.send(nil)
        // THEN
        wait(for: [didReceiveValue, didReceiveFailure], timeout: 0.5)
        XCTAssertNotNil(cancellable)
    }
}

private class DummyInteractor: AuthenticatedInteractor {
    func executeAsync() async throws -> String {
        try assertIsAuthenticated()
        return "Hello world!"
    }
    
    func executePublisher() -> AnyPublisher<String, NablaError> {
        isAuthenticated
            .map { "Hello world!" }
            .eraseToAnyPublisher()
    }
}
