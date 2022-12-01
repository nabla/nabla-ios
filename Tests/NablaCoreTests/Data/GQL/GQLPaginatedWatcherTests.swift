import Apollo
import NablaCore
import NablaCoreTestsUtils
import XCTest

class GQLPaginatedWatcherTests: XCTestCase {
    private let gqlClient = GQLClientMock()
    private let gqlStore = GQLStoreMock()
    private let watcher = WatcherMock()
    
    override func setUp() {
        super.setUp()
        
        gqlClient.given(.watch(query: .any(MockQuery.self), cachePolicy: .any, handler: .any, willReturn: watcher))
    }

    func testWatcherIsCancelledOnDeinit() throws {
        // GIVEN
        var sut: TestPaginatedWatcher? = .init(
            gqlClient: gqlClient,
            gqlStore: gqlStore,
            numberOfItemsPerPage: 50,
            preloadCache: false,
            handler: .void
        )
        // WHEN
        sut = nil
        // THEN
        watcher.verify(.cancel())
        XCTAssertNil(sut) // Silences "sut not used" warning
    }
}

private final class TestPaginatedWatcher: GQLPaginatedWatcher<MockQuery> {
    override func makeQuery(cursor _: String??, numberOfItems _: Int) -> MockQuery {
        MockQuery()
    }
}

private final class MockQuery: PaginatedQuery {
    var operationDefinition: String { "MockQuery" }
    
    var operationName: String { "MockQuery" }
    
    typealias Data = MockSelectionSet
    
    static func getCursor(from _: Data) -> String? { nil }
}

private struct MockSelectionSet: Apollo.GraphQLSelectionSet {
    static var selections: [GraphQLSelection] { [] }
    
    var resultMap: ResultMap = [:]
    
    init(unsafeResultMap: ResultMap) {
        resultMap = unsafeResultMap
    }
}
