@testable import NablaMessagingCore
import NablaUtils
import SwiftyMocky
import XCTest

class ConversationItemRemoteDataSourceTests: XCTestCase {
    private var mockGqlClient: GQLClientMock!
    private var mockGqlStore: GQLStoreMock!

    override func setUp() {
        super.setUp()
        mockGqlClient = GQLClientMock()
        mockGqlStore = GQLStoreMock()
        
        Resolver.shared.register(type: GQLClient.self, mockGqlClient)
        Resolver.shared.register(type: GQLStore.self, mockGqlStore)
        
        Matcher.default.register(GQL.MaskAsSeenMutation.self) { lhs, rhs in
            lhs.conversationId == rhs.conversationId
        }
    }
    
    override func tearDown() {
        mockGqlClient = nil
        mockGqlStore = nil
    }

    func testMarkConversationAsSeenCallsClientWithCorrectMutation() {
        // GIVEN
        let conversationId = UUID()
        let sut = ConversationItemRemoteDataSourceImpl()
        Given(mockGqlClient, .perform(mutation: .any(GQL.MaskAsSeenMutation.self), handler: .any, willReturn: CancellableMock()))
        // WHEN
        _ = sut.markConversationAsSeen(conversationId: conversationId, handler: .void)
        // THEN
        Verify(mockGqlClient, .perform(mutation: .value(GQL.MaskAsSeenMutation(conversationId: conversationId)), handler: .any))
    }
}
