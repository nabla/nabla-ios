import NablaCore
import NablaCoreTestsUtils
@testable import NablaMessagingCore
import NablaMessagingCoreTestsUtils
import SwiftyMocky
import XCTest

class ConversationRemoteDataSourceTests: XCTestCase {
    private var mockGqlClient: GQLClientMock!
    private var mockAsyncGqlClient: AsyncGQLClientMock!
    private var mockGqlStore: GQLStoreMock!

    override func setUp() {
        super.setUp()
        mockGqlClient = GQLClientMock()
        mockAsyncGqlClient = AsyncGQLClientMock()
        mockGqlStore = GQLStoreMock()
        
        Matcher.default.register(GQL.MaskAsSeenMutation.self) { lhs, rhs in
            lhs.conversationId == rhs.conversationId
        }
    }
    
    override func tearDown() {
        mockGqlClient = nil
        mockGqlStore = nil
    }

    func testMarkConversationAsSeenCallsClientWithCorrectMutation() async throws {
        // GIVEN
        let conversationId = UUID()
        let sut = ConversationRemoteDataSourceImpl(
            gqlClient: mockGqlClient,
            asyncGqlClient: mockAsyncGqlClient,
            gqlStore: mockGqlStore
        )
        mockAsyncGqlClient.given(.perform(mutation: .any(GQL.MaskAsSeenMutation.self), willReturn: .init(unsafeResultMap: [:])))
        // WHEN
        _ = try await sut.markConversationAsSeen(conversationId: conversationId)
        // THEN
        mockAsyncGqlClient.verify(.perform(mutation: .value(GQL.MaskAsSeenMutation(conversationId: conversationId))))
    }
}
