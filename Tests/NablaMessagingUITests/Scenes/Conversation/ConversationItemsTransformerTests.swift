@testable import NablaMessagingCore
import NablaMessagingCoreTestsUtils
@testable import NablaMessagingUI
import XCTest

final class ConversationItemsTransformerTests: XCTestCase {
    private var conversation: Conversation!

    override func setUp() {
        super.setUp()
        conversation = .mock()
    }

    private func transform(
        items: [ConversationItem],
        hasMore: Bool = false,
        focusedTextItemId: UUID? = nil
    ) -> [ConversationViewItem] {
        ConversationItemsTransformer.transform(
            conversationItems: ConversationItems(
                conversationId: conversation.id,
                hasMore: hasMore,
                items: items
            ),
            conversation: conversation,
            focusedTextItemId: focusedTextItemId
        )
    }

    func testEmptyConversation() {
        // GIVEN
        // WHEN
        let transformed = transform(items: [])
        // THEN
        XCTRequireEqual(transformed.count, 0)
    }
    
    // MARK: - Contiguous
    
    func testTwoConsecutiveMessagesWithTheSameAuthorAreContiguous() {
        // GIVEN
        let provider = Provider.mock()
        // WHEN
        let transformed = transform(items: [
            TextMessageItem.mock(sender: .provider(provider)),
            TextMessageItem.mock(sender: .provider(provider)),
        ])
        // THEN
        XCTRequireEqual(transformed.count, 3)
        let text1 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[2], toBe: TextMessageViewItem.self)
        XCTAssertTrue(text2.isContiguous)
    }
    
    func testTwoConsecutiveMessagesSentByPatientAreContiguous() {
        // GIVEN
        // WHEN
        let transformed = transform(items: [
            TextMessageItem.mock(sender: .patient),
            TextMessageItem.mock(sender: .patient),
        ])
        // THEN
        XCTRequireEqual(transformed.count, 3)
        let text1 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[2], toBe: TextMessageViewItem.self)
        XCTAssertTrue(text2.isContiguous)
    }
    
    func testTwoConsecutiveMessagesSentBySystemAreContiguous() {
        // GIVEN
        let provider = SystemProvider(avatarURL: nil, name: "nablo")
        // WHEN
        let transformed = transform(items: [
            TextMessageItem.mock(sender: .system(provider)),
            TextMessageItem.mock(sender: .system(provider)),
        ])
        // THEN
        XCTRequireEqual(transformed.count, 3)
        let text1 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[2], toBe: TextMessageViewItem.self)
        XCTAssertTrue(text2.isContiguous)
    }
    
    func testTwoConsecutiveMessagesSentByDeletedProviderAreContiguous() {
        // GIVEN
        // WHEN
        let transformed = transform(items: [
            TextMessageItem.mock(sender: .deleted),
            TextMessageItem.mock(sender: .deleted),
        ])
        // THEN
        XCTRequireEqual(transformed.count, 3)
        let text1 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[2], toBe: TextMessageViewItem.self)
        XCTAssertTrue(text2.isContiguous)
    }
    
    func testTwoConsecutiveMessagesWithDifferentAuthorsAreNotContiguous() {
        // GIVEN
        // WHEN
        let transformed = transform(items: [
            TextMessageItem.mock(sender: .provider(.mock())),
            TextMessageItem.mock(sender: .provider(.mock())),
        ])
        // THEN
        XCTRequireEqual(transformed.count, 3)
        let text1 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[2], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text2.isContiguous)
    }
    
    func testTwoNonConsecutiveMessagesWithTheSameAuthorAreNotContiguous() {
        // GIVEN
        let provider1 = Provider.mock()
        let provider2 = Provider.mock()
        // WHEN
        let transformed = transform(items: [
            TextMessageItem.mock(sender: .provider(provider1)),
            TextMessageItem.mock(sender: .provider(provider2)),
            TextMessageItem.mock(sender: .provider(provider1)),
        ])
        // THEN
        XCTRequireEqual(transformed.count, 4)
        let text1 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[2], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text2.isContiguous)
        let text3 = XCTRequire(transformed[3], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text3.isContiguous)
    }
    
    func testManyConsecutiveMessageWithTheSameAuthorAreContiguous() {
        // GIVEN
        let provider1 = Provider.mock()
        let group1 = (1 ... 10).map { _ in TextMessageItem.mock(sender: .provider(provider1)) }
        let provider2 = Provider.mock()
        let group2 = (1 ... 20).map { _ in TextMessageItem.mock(sender: .provider(provider2)) }
        // WHEN
        let transformed = transform(items: group1 + group2)
        // THEN
        XCTRequireEqual(transformed.count, 31)
        
        // #0 -> Date
        // #1 -> Not contiguous
        // #2 ... #10 -> Contiguous
        // #11 -> Not contiguous
        // #12 ... #30 -> Contiguous
        
        let text1FromGroup1 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1FromGroup1.isContiguous)
        (2 ... 10).forEach { index in
            let text = XCTRequire(transformed[index], toBe: TextMessageViewItem.self)
            XCTAssertTrue(text.isContiguous, "For item at index \(index)")
        }
        
        let text1FromGroup2 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1FromGroup2.isContiguous)
        (12 ... 30).forEach { index in
            let text = XCTRequire(transformed[index], toBe: TextMessageViewItem.self)
            XCTAssertTrue(text.isContiguous, "For item at index \(index)")
        }
    }
    
    // MARK: - Date separators

    func testSingleMessagesUseSingleDateSeparator() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        // WHEN
        let transformed = transform(items: [item1])
        // THEN
        XCTRequireEqual(transformed.count, 2)
        XCTAssert(transformed[0] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(transformed[1].id, item1.id)
    }
    
    func testTwoConsecutiveMessagesUseSingleDataSeparator() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 1)
        // WHEN
        let transformed = transform(items: [item1, item2])
        // THEN
        XCTRequireEqual(transformed.count, 3)
        XCTAssert(transformed[0] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(transformed[1].id, item1.id)
        XCTAssert(transformed[2] is TextMessageViewItem)
        XCTAssertEqual(transformed[2].id, item2.id)
    }
    
    func testTwoNonConsecutiveMessagesUseOneDateSeparatorEach() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 60 * 60 * 2 + 1)
        // WHEN
        let transformed = transform(items: [item1, item2])
        // THEN
        XCTRequireEqual(transformed.count, 4)
        XCTAssert(transformed[0] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(transformed[1].id, item1.id)
        XCTAssert(transformed[2] is DateSeparatorViewItem)
        XCTAssert(transformed[3] is TextMessageViewItem)
        XCTAssertEqual(transformed[3].id, item2.id)
    }
    
    func testTwoAlmostNonConsecutiveMessagesUseSingleDateSeparator() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 60 * 60 * 2 - 1)
        // WHEN
        let transformed = transform(items: [item1, item2])
        // THEN
        XCTRequireEqual(transformed.count, 3)
        XCTAssert(transformed[0] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(transformed[1].id, item1.id)
        XCTAssert(transformed[2] is TextMessageViewItem)
        XCTAssertEqual(transformed[2].id, item2.id)
    }
    
    func testTwoNonConsecutiveGroupsOfMessageUseOneDateSeparatorEach() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 1)
        let item3 = TextMessageItem.mock(dateOffset: 60 * 60 * 2 + 1)
        let item4 = TextMessageItem.mock(dateOffset: 60 * 60 * 2 + 2)
        // WHEN
        let transformed = transform(items: [item1, item2, item3, item4])
        // THEN
        XCTRequireEqual(transformed.count, 6)
        XCTAssert(transformed[0] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(transformed[1].id, item1.id)
        XCTAssert(transformed[2] is TextMessageViewItem)
        XCTAssertEqual(transformed[2].id, item2.id)
        XCTAssert(transformed[3] is DateSeparatorViewItem)
        XCTAssert(transformed[4] is TextMessageViewItem)
        XCTAssertEqual(transformed[4].id, item3.id)
        XCTAssert(transformed[5] is TextMessageViewItem)
        XCTAssertEqual(transformed[5].id, item4.id)
    }

    // MARK: - Focused Text Item

    func testSingleFocusedMessageDoesNotAddDateSeparator() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0, sender: .patient)
        // WHEN
        let transformed = transform(items: [item1], focusedTextItemId: item1.id)
        // THEN
        XCTRequireEqual(transformed.count, 2)
        XCTAssert(transformed[0] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(true, (transformed[1] as? ConversationViewMessageItem)?.isFocused)
    }
    
    func testFocusedTextMessageNotContiguousAddsDateSeparator() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0, sender: .patient)
        let item2 = TextMessageItem.mock(dateOffset: 1, sender: .patient)
        // WHEN
        let transformed = transform(items: [item1, item2], focusedTextItemId: item2.id)
        // THEN
        XCTRequireEqual(transformed.count, 4)
        XCTAssert(transformed[0] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssert(transformed[2] is DateSeparatorViewItem)
        XCTAssertEqual(item2.date, (transformed[2] as? DateSeparatorViewItem)?.date)
        XCTAssert(transformed[3] is TextMessageViewItem)
        XCTAssertEqual(true, (transformed[3] as? ConversationViewMessageItem)?.isFocused)
    }
}
