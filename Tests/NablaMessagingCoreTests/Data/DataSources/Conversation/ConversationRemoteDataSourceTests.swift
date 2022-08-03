import NablaCore
import NablaCoreTestsUtils
@testable import NablaMessagingCore
import NablaMessagingCoreTestsUtils
import SwiftyMocky
import XCTest

class ConversationRemoteDataSourceTests: XCTestCase {
    private var mockGqlClient: GQLClientMock!
    private var mockGqlStore: GQLStoreMock!

    override func setUp() {
        super.setUp()
        mockGqlClient = GQLClientMock()
        mockGqlStore = GQLStoreMock()
        
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
        let sut = ConversationRemoteDataSourceImpl(gqlClient: mockGqlClient, gqlStore: mockGqlStore)
        Given(mockGqlClient, .perform(mutation: .any(GQL.MaskAsSeenMutation.self), handler: .any, willReturn: CancellableMock()))
        // WHEN
        _ = sut.markConversationAsSeen(conversationId: conversationId, handler: .void)
        // THEN
        Verify(mockGqlClient, .perform(mutation: .value(GQL.MaskAsSeenMutation(conversationId: conversationId)), handler: .any))
    }
}
