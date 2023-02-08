import Combine
@testable import NablaCore
import XCTest

final class ApolloPublisherTests: XCTestCase {
    func testWorkerIsStartedOnSubscribe() {
        // GIVEN
        let (sut, worker) = makeApolloPublisher(type: Int.self)
        worker.verify(.start, count: 0)
        
        // WHEN
        let cancellable = sut.sink { _ in
            XCTFail("Should not receive errors")
        } receiveValue: { _ in
            XCTFail("Should not receive values")
        }
        
        // THEN
        worker.verify(.start, count: 1)
        cancellable.cancel()
    }
    
    func testWorkerIsCanceledOnCancel() {
        // GIVEN
        let (sut, worker) = makeApolloPublisher(type: Int.self)
        let cancellable = sut.sink { _ in
            XCTFail("Should not receive errors")
        } receiveValue: { _ in
            XCTFail("Should not receive values")
        }
        
        // WHEN
        cancellable.cancel()
        
        // THEN
        worker.verify(.cancel)
    }
    
    func testWorkerIsCanceledOnFailure() {
        // GIVEN
        let (sut, worker) = makeApolloPublisher(type: Int.self)
        let publisherDidFail = expectation(description: "Publisher did fail")
        
        var emittedValues = [Int]()
        var receivedValues = [Int]()
        let cancellable = sut
            .handleEvents(receiveOutput: { output in
                emittedValues.append(output)
            })
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail("Publisher should not finish")
                case let .failure(error):
                    XCTAssert(error is DummyError)
                    publisherDidFail.fulfill()
                }
            } receiveValue: { value in
                receivedValues.append(value)
            }
        
        // WHEN
        worker.send(1)
        worker.send(2)
        worker.send(error: DummyError())
        worker.send(3)
        
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertEqual(emittedValues, [1, 2])
        XCTAssertEqual(receivedValues, [1, 2])
        worker.verify(.start, count: 1)
        worker.verify(.cancel, count: 1)
        cancellable.cancel()
    }
    
    func testWorkerIsStartedOnRetry() {
        // GIVEN
        let (sut, worker) = makeApolloPublisher(type: Int.self)
        
        var emittedValues = [Int]()
        var receivedValues = [Int]()
        let cancellable = sut
            .handleEvents(receiveOutput: { output in
                emittedValues.append(output)
            })
            .retry(1)
            .sink { _ in
                XCTFail("Publisher should not complete")
            } receiveValue: { value in
                receivedValues.append(value)
            }
        
        // WHEN
        worker.send(1)
        worker.send(2)
        worker.send(error: DummyError())
        worker.send(3)
        
        // THEN
        XCTAssertEqual(emittedValues, [1, 2, 3])
        XCTAssertEqual(receivedValues, [1, 2, 3])
        worker.verify(.start, count: 2)
        worker.verify(.cancel, count: 1)
        cancellable.cancel()
    }
    
    private func makeApolloPublisher<T>(type _: T.Type) -> (ApolloPublisher<T>, MockWorker<T>) {
        let worker = MockWorker<T>()
        let publisher = ApolloPublisher<T> { resultHandler in
            worker.start(resultHandler)
            return worker
        }
        return (publisher, worker)
    }
}

private struct DummyError: Error, Equatable {}

private final class MockWorker<T: Equatable>: Combine.Cancellable {
    // MARK: - Internal
    
    func start(_ resultHandler: @escaping (Result<T, Error>) -> Void) {
        invocations.append(.start)
        self.resultHandler = resultHandler
    }
    
    func cancel() {
        invocations.append(.cancel)
        resultHandler = nil
    }
    
    func send(_ value: T) {
        invocations.append(.send(value: value))
        resultHandler?(.success(value))
    }
    
    func send(error: DummyError) {
        invocations.append(.send(error: error))
        resultHandler?(.failure(error))
    }
    
    enum Invocation: Equatable {
        // swiftlint:disable duplicate_enum_cases
        case start
        case send(value: T)
        case send(error: DummyError)
        case cancel
        // swiftlint:enable duplicate_enum_cases
    }
    
    func verify(_ invocation: Invocation, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssert(invocations.contains(invocation), file: file, line: line)
    }
    
    func verify(_ invocation: Invocation, count: Int, file: StaticString = #filePath, line: UInt = #line) {
        let matches = invocations.filter { $0 == invocation }
        XCTAssertEqual(matches.count, count, file: file, line: line)
    }
    
    // MARK: - Private
    
    private var resultHandler: ((Result<T, Error>) -> Void)?
    private var invocations = [Invocation]()
}
