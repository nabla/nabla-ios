import Apollo
import ApolloAPI
@testable import NablaCore
import NablaCoreTestsUtils
import XCTest

final class IApolloClientTests: XCTestCase {
    private var sut: MockApolloClientInterface!

    override func setUp() {
        sut = .init()
    }
    
    func testWatchAndUpdateReceivesDataFromCacheThenEmitsIt() {
        // GIVEN
        let didReceiveValue = expectation(description: "Did receive value")
        let query = MockQuery()
        let publisher = sut.watchAndUpdate(query: query)
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected finish")
                case let .failure(error):
                    XCTFail("Unexpected error \(error)")
                }
            },
            receiveValue: { value in
                XCTAssertFalse(value.isDataFresh)
                XCTAssert(value.refreshingState.isEqual(to: .refreshing))
                didReceiveValue.fulfill()
            }
        )
        let watcher = sut.watcher(for: query)
        
        // WHEN
        let result = GraphQLResult(
            data: MockData(value: 42),
            extensions: nil,
            errors: nil,
            source: .cache,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(result))
        
        // THEN
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
    
    func testWatchAndUpdateReceivesDataFromServerThenEmitsIt() {
        // GIVEN
        let didReceiveValue = expectation(description: "Did receive value")
        let query = MockQuery()
        let publisher = sut.watchAndUpdate(query: query)
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected finish")
                case let .failure(error):
                    XCTFail("Unexpected error \(error)")
                }
            },
            receiveValue: { value in
                XCTAssertTrue(value.isDataFresh)
                XCTAssert(value.refreshingState.isEqual(to: .refreshed))
                didReceiveValue.fulfill()
            }
        )
        let watcher = sut.watcher(for: query)
        
        // WHEN
        let result = GraphQLResult(
            data: MockData(value: 42),
            extensions: nil,
            errors: nil,
            source: .server,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(result))
        
        // THEN
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }

    func testWatchAndUpdateReceivesErrorThenCompletesPublisher() {
        // GIVEN
        let didReceiveError = expectation(description: "Did receive error")
        let query = MockQuery()
        let publisher = sut.watchAndUpdate(query: query)
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected finish")
                case let .failure(error):
                    XCTAssert(error is MockError)
                    didReceiveError.fulfill()
                }
            },
            receiveValue: { value in
                XCTFail("Unexpected value \(value)")
            }
        )
        let watcher = sut.watcher(for: query)
        
        // WHEN
        watcher.resultHandler(.failure(MockError.mockFailure))
        
        // THEN
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
    
    func testWatchAndUpdateReceivesPartialErrorThenCompletesPublisher() {
        // GIVEN
        let didReceiveError = expectation(description: "Did receive error")
        let query = MockQuery()
        let publisher = sut.watchAndUpdate(query: query)
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected finish")
                case let .failure(error):
                    XCTAssert(error is GraphQLError)
                    didReceiveError.fulfill()
                }
            },
            receiveValue: { value in
                XCTFail("Unexpected value \(value)")
            }
        )
        let watcher = sut.watcher(for: query)
        
        // WHEN
        let result = GraphQLResult<MockData>(
            data: nil,
            extensions: nil,
            errors: [.init(["message": "Error"])],
            source: .server,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(result))
        
        // THEN
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
    
    func testWatchAndUpdateReceivesDataWithPartialErrorThenEmitsValue() {
        // GIVEN
        let didReceiveValue = expectation(description: "Did receive value")
        let query = MockQuery()
        let publisher = sut.watchAndUpdate(query: query)
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected finish")
                case let .failure(error):
                    XCTFail("Unexpected error \(error)")
                }
            },
            receiveValue: { _ in
                didReceiveValue.fulfill()
            }
        )
        let watcher = sut.watcher(for: query)
        
        // WHEN
        let result = GraphQLResult(
            data: MockData(value: 42),
            extensions: nil,
            errors: [.init(["message": "Error"])],
            source: .server,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(result))
        
        // THEN
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
    
    func testWatchAndUpdateReceivesDataFromCacheAndDataFromServerThenEmitsNewData() {
        // GIVEN
        let didReceiveFirstValue = expectation(description: "Did receive first value")
        let didReceiveSecondValue = expectation(description: "Did receive second value")
        let query = MockQuery()
        let publisher = sut.watchAndUpdate(query: query)
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected finish")
                case let .failure(error):
                    XCTFail("Unexpected error \(error)")
                }
            },
            receiveValue: { value in
                switch value.data.value {
                case 1:
                    XCTAssertFalse(value.isDataFresh)
                    XCTAssert(value.refreshingState.isEqual(to: .refreshing))
                    didReceiveFirstValue.fulfill()
                case 2:
                    XCTAssertTrue(value.isDataFresh)
                    XCTAssert(value.refreshingState.isEqual(to: .refreshed))
                    didReceiveSecondValue.fulfill()
                default: XCTFail("Unexpected value \(value)")
                }
            }
        )
        let watcher = sut.watcher(for: query)
        
        // WHEN
        let firstResult = GraphQLResult(
            data: MockData(value: 1),
            extensions: nil,
            errors: nil,
            source: .cache,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(firstResult))
        let secondResult = GraphQLResult(
            data: MockData(value: 2),
            extensions: nil,
            errors: nil,
            source: .server,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(secondResult))
        
        // THEN
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
    
    func testWatchAndUpdateReceivesDataFromCacheAndErrorFromServerThenEmitsOldData() {
        // GIVEN
        let didReceiveFirstValue = expectation(description: "Did receive first value")
        let didReceiveSecondValue = expectation(description: "Did receive second value")
        let query = MockQuery()
        let publisher = sut.watchAndUpdate(query: query)
        
        var valueCount = 0
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected finish")
                case let .failure(error):
                    XCTFail("Unexpected error \(error)")
                }
            },
            receiveValue: { value in
                defer { valueCount += 1 }
                switch valueCount {
                case 0:
                    XCTAssertFalse(value.isDataFresh)
                    XCTAssert(value.refreshingState.isEqual(to: .refreshing))
                    XCTAssertEqual(value.data.value, 1)
                    didReceiveFirstValue.fulfill()
                case 1:
                    XCTAssertFalse(value.isDataFresh)
                    XCTAssert(value.refreshingState.isEqual(to: .failed(error: MockError.mockFailure)))
                    XCTAssertEqual(value.data.value, 1)
                    didReceiveSecondValue.fulfill()
                default: XCTFail("Unexpected value \(value)")
                }
            }
        )
        let watcher = sut.watcher(for: query)
        
        // WHEN
        let firstResult = GraphQLResult(
            data: MockData(value: 1),
            extensions: nil,
            errors: nil,
            source: .cache,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(firstResult))
        watcher.resultHandler(.failure(MockError.mockFailure))
        
        // THEN
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
    
    func testWatchAndUpdateReceivesDataFromCacheAndPartialErrorFromServerThenEmitsOldData() {
        // GIVEN
        let didReceiveFirstValue = expectation(description: "Did receive first value")
        let didReceiveSecondValue = expectation(description: "Did receive second value")
        let query = MockQuery()
        let publisher = sut.watchAndUpdate(query: query)
        let error = GraphQLError(["message": "Error"])
        
        var valueCount = 0
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected finish")
                case let .failure(error):
                    XCTFail("Unexpected error \(error)")
                }
            },
            receiveValue: { value in
                defer { valueCount += 1 }
                switch valueCount {
                case 0:
                    XCTAssertFalse(value.isDataFresh)
                    XCTAssert(value.refreshingState.isEqual(to: .refreshing))
                    XCTAssertEqual(value.data.value, 1)
                    didReceiveFirstValue.fulfill()
                case 1:
                    XCTAssertFalse(value.isDataFresh)
                    XCTAssert(value.refreshingState.isEqual(to: .failed(error: error)))
                    XCTAssertEqual(value.data.value, 1)
                    didReceiveSecondValue.fulfill()
                default: XCTFail("Unexpected value \(value)")
                }
            }
        )
        let watcher = sut.watcher(for: query)
        
        // WHEN
        let firstResult = GraphQLResult(
            data: MockData(value: 1),
            extensions: nil,
            errors: nil,
            source: .cache,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(firstResult))
        let secondResult = GraphQLResult<MockData>(
            data: nil,
            extensions: nil,
            errors: [error],
            source: .server,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(secondResult))
        
        // THEN
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
    
    func testWatchAndUpdateReceivesDataFromCacheAndDataWithPartialErrorFromServerThenEmitsNewData() {
        // GIVEN
        let didReceiveFirstValue = expectation(description: "Did receive first value")
        let didReceiveSecondValue = expectation(description: "Did receive second value")
        let query = MockQuery()
        let publisher = sut.watchAndUpdate(query: query)
        let error = GraphQLError(["message": "Error"])
        
        var valueCount = 0
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected finish")
                case let .failure(error):
                    XCTFail("Unexpected error \(error)")
                }
            },
            receiveValue: { value in
                defer { valueCount += 1 }
                switch valueCount {
                case 0:
                    XCTAssertFalse(value.isDataFresh)
                    XCTAssert(value.refreshingState.isEqual(to: .refreshing))
                    XCTAssertEqual(value.data.value, 1)
                    didReceiveFirstValue.fulfill()
                case 1:
                    XCTAssertFalse(value.isDataFresh)
                    XCTAssert(value.refreshingState.isEqual(to: .failed(error: error)))
                    XCTAssertEqual(value.data.value, 2)
                    didReceiveSecondValue.fulfill()
                default: XCTFail("Unexpected value \(value)")
                }
            }
        )
        let watcher = sut.watcher(for: query)
        
        // WHEN
        let firstResult = GraphQLResult(
            data: MockData(value: 1),
            extensions: nil,
            errors: nil,
            source: .cache,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(firstResult))
        let secondResult = GraphQLResult(
            data: MockData(value: 2),
            extensions: nil,
            errors: [error],
            source: .server,
            dependentKeys: nil
        )
        watcher.resultHandler(.success(secondResult))
        
        // THEN
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
}

private class MockQuery: GraphQLQuery {
    typealias Data = MockData
    
    static let operationName = "MockQuery"
    static var document: DocumentType = .notPersisted(definition: .init(""))
}

private struct MockData: GQL.SelectionSet {
    // swiftlint:disable identifier_name
    static var __parentType: ParentType { fatalError() }
    static let __selections = [Selection]()
    
    let __data: DataDict
    // swiftlint:enable identifier_name
    
    init(data: DataDict) { __data = data }
    
    var value: Int? {
        __data._data["value"] as? Int
    }
    
    init(value: Int) {
        __data = .init(["value": value], variables: nil)
    }
}

private class MockApolloClientInterface: IApolloClient {
    private var watchers = [String: Any]()
    
    func watcher<Query: GQLQuery>(for _: Query) -> MockGraphQLQueryWatcher<Query> {
        if let watcher = watchers[Query.operationName] as? MockGraphQLQueryWatcher<Query> {
            return watcher
        }
        fatalError("Watcher not found. Call MockApolloClientInterface.watch(query:cachePolicy:resultHandler:) first.")
    }
    
    func watch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy _: NablaCore.CachePolicy,
        resultHandler: @escaping GraphQLResultHandler<Query.Data>
    ) -> IGraphQLQueryWatcher {
        let watcher = MockGraphQLQueryWatcher(query: query, resultHandler: resultHandler)
        watchers[Query.operationName] = watcher
        return watcher
    }
    
    func subscribe<Subscription: GraphQLSubscription>(
        subscription _: Subscription,
        resultHandler _: @escaping GraphQLResultHandler<Subscription.Data>
    ) -> Apollo.Cancellable {
        fatalError()
    }
}

private class MockGraphQLQueryWatcher<Query: GraphQLQuery>: IGraphQLQueryWatcher {
    let resultHandler: GraphQLResultHandler<Query.Data>
    
    func refetch(cachePolicy _: CachePolicy) {}
    
    func cancel() {}
    
    init(
        query _: Query,
        resultHandler: @escaping GraphQLResultHandler<Query.Data>
    ) {
        self.resultHandler = resultHandler
    }
}

private enum MockError: Error {
    case mockFailure
}

private extension RefreshingState {
    func isEqual(to other: RefreshingState<Error>) -> Bool {
        switch (self, other) {
        case (.refreshing, .refreshing): return true
        case (.refreshed, .refreshed): return true
        case let (.failed(lhs), .failed(rhs)): return lhs.localizedDescription == rhs.localizedDescription
        default: return false
        }
    }
}
