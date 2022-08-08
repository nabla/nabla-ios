@testable import NablaMessagingCore
import NablaMessagingCoreTestsUtils
@testable import NablaMessagingUI
import XCTest

final class ConversationItemsTransformerTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    private func transform(
        items: [ConversationItem],
        hasMore: Bool = false,
        focusedTextItemId: UUID? = nil
    ) -> [ConversationViewItem] {
        ConversationItemsTransformer.transform(
            conversationItems: ConversationItems(
                hasMore: hasMore,
                items: items
            ),
            providers: [],
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
        _ = XCTRequire(transformed[2], toBe: DateSeparatorViewItem.self)
        let text1 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[0], toBe: TextMessageViewItem.self)
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
        _ = XCTRequire(transformed[2], toBe: DateSeparatorViewItem.self)
        let text1 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[0], toBe: TextMessageViewItem.self)
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
        let text2 = XCTRequire(transformed[0], toBe: TextMessageViewItem.self)
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
        let text2 = XCTRequire(transformed[0], toBe: TextMessageViewItem.self)
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
        _ = XCTRequire(transformed[2], toBe: DateSeparatorViewItem.self)
        let text1 = XCTRequire(transformed[0], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
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
        let text1 = XCTRequire(transformed[2], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1.isContiguous)
        let text2 = XCTRequire(transformed[1], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text2.isContiguous)
        let text3 = XCTRequire(transformed[0], toBe: TextMessageViewItem.self)
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
        
        // #30 -> Date
        // #29 -> Not contiguous
        // #10 ... #28 -> Contiguous
        // #9 -> Not contiguous
        // #0 ... #8 -> Contiguous
        
        let text1FromGroup1 = XCTRequire(transformed[29], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1FromGroup1.isContiguous)
        (10 ... 28).forEach { index in
            let text = XCTRequire(transformed[index], toBe: TextMessageViewItem.self)
            XCTAssertTrue(text.isContiguous, "For item at index \(index)")
        }
        
        let text1FromGroup2 = XCTRequire(transformed[9], toBe: TextMessageViewItem.self)
        XCTAssertFalse(text1FromGroup2.isContiguous)
        (0 ... 8).forEach { index in
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
        XCTAssert(transformed[1] is DateSeparatorViewItem)
        XCTAssert(transformed[0] is TextMessageViewItem)
        XCTAssertEqual(transformed[0].id, item1.id)
    }
    
    func testTwoConsecutiveMessagesUseSingleDataSeparator() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 1)
        // WHEN
        let transformed = transform(items: [item1, item2])
        // THEN
        XCTRequireEqual(transformed.count, 3)
        XCTAssert(transformed[2] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(transformed[1].id, item2.id)
        XCTAssert(transformed[0] is TextMessageViewItem)
        XCTAssertEqual(transformed[0].id, item1.id)
    }
    
    func testTwoNonConsecutiveMessagesUseOneDateSeparatorEach() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 60 * 60)
        // WHEN
        let transformed = transform(items: [item1, item2])
        // THEN
        XCTRequireEqual(transformed.count, 4)
        XCTAssert(transformed[3] is DateSeparatorViewItem)
        XCTAssert(transformed[2] is TextMessageViewItem)
        XCTAssertEqual(transformed[2].id, item2.id)
        XCTAssert(transformed[1] is DateSeparatorViewItem)
        XCTAssert(transformed[0] is TextMessageViewItem)
        XCTAssertEqual(transformed[0].id, item1.id)
    }
    
    func testThreeNonConsecutiveMessagesUseOneDateSeparatorEach() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 60 * 60)
        let item3 = TextMessageItem.mock(dateOffset: 60 * 60 * 2)
        // WHEN
        let transformed = transform(items: [item1, item2, item3])
        // THEN
        XCTRequireEqual(transformed.count, 6)
        XCTAssert(transformed[5] is DateSeparatorViewItem)
        XCTAssert(transformed[4] is TextMessageViewItem)
        XCTAssertEqual(transformed[4].id, item3.id)
        XCTAssert(transformed[3] is DateSeparatorViewItem)
        XCTAssert(transformed[2] is TextMessageViewItem)
        XCTAssertEqual(transformed[2].id, item2.id)
        XCTAssert(transformed[1] is DateSeparatorViewItem)
        XCTAssert(transformed[0] is TextMessageViewItem)
        XCTAssertEqual(transformed[0].id, item1.id)
    }
    
    func testTwoAlmostNonConsecutiveMessagesUseSingleDateSeparator() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 60 * 60 - 1)
        // WHEN
        let transformed = transform(items: [item1, item2])
        // THEN
        XCTRequireEqual(transformed.count, 3)
        XCTAssert(transformed[2] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(transformed[1].id, item2.id)
        XCTAssert(transformed[0] is TextMessageViewItem)
        XCTAssertEqual(transformed[0].id, item1.id)
    }
    
    func testTwoNonConsecutiveGroupsOfMessageUseOneDateSeparatorEach() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 1)
        let item3 = TextMessageItem.mock(dateOffset: 60 * 60 + 1)
        let item4 = TextMessageItem.mock(dateOffset: 60 * 60 + 2)
        // WHEN
        let transformed = transform(items: [item1, item2, item3, item4])
        // THEN
        XCTRequireEqual(transformed.count, 6)
        XCTAssert(transformed[5] is DateSeparatorViewItem)
        XCTAssert(transformed[4] is TextMessageViewItem)
        XCTAssertEqual(transformed[4].id, item4.id)
        XCTAssert(transformed[3] is TextMessageViewItem)
        XCTAssertEqual(transformed[3].id, item3.id)
        XCTAssert(transformed[2] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(transformed[1].id, item2.id)
        XCTAssert(transformed[0] is TextMessageViewItem)
        XCTAssertEqual(transformed[0].id, item1.id)
    }
    
    func testThreeNonConsecutiveGroupsOfMessageUseOneDateSeparatorEach() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0)
        let item2 = TextMessageItem.mock(dateOffset: 1)
        let item3 = TextMessageItem.mock(dateOffset: 60 * 60 + 1)
        let item4 = TextMessageItem.mock(dateOffset: 60 * 60 + 2)
        let item5 = TextMessageItem.mock(dateOffset: 60 * 60 * 2 + 2)
        let item6 = TextMessageItem.mock(dateOffset: 60 * 60 * 2 + 3)
        // WHEN
        let transformed = transform(items: [item1, item2, item3, item4, item5, item6])
        // THEN
        XCTRequireEqual(transformed.count, 9)
        XCTAssert(transformed[8] is DateSeparatorViewItem)
        XCTAssert(transformed[7] is TextMessageViewItem)
        XCTAssertEqual(transformed[7].id, item6.id)
        XCTAssert(transformed[6] is TextMessageViewItem)
        XCTAssertEqual(transformed[6].id, item5.id)
        XCTAssert(transformed[5] is DateSeparatorViewItem)
        XCTAssert(transformed[4] is TextMessageViewItem)
        XCTAssertEqual(transformed[4].id, item4.id)
        XCTAssert(transformed[3] is TextMessageViewItem)
        XCTAssertEqual(transformed[3].id, item3.id)
        XCTAssert(transformed[2] is DateSeparatorViewItem)
        XCTAssert(transformed[1] is TextMessageViewItem)
        XCTAssertEqual(transformed[1].id, item2.id)
        XCTAssert(transformed[0] is TextMessageViewItem)
        XCTAssertEqual(transformed[0].id, item1.id)
    }

    // MARK: - Focused Text Item

    func testSingleFocusedMessageDoesNotAddDateSeparator() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0, sender: .patient)
        // WHEN
        let transformed = transform(items: [item1], focusedTextItemId: item1.id)
        // THEN
        XCTRequireEqual(transformed.count, 2)
        XCTAssert(transformed[1] is DateSeparatorViewItem)
        XCTAssert(transformed[0] is TextMessageViewItem)
        XCTAssertEqual(true, (transformed[0] as? ConversationViewMessageItem)?.isFocused)
    }
    
    func testFocusedTextMessageNotContiguousAddsDateSeparator() throws {
        // GIVEN
        let item1 = TextMessageItem.mock(dateOffset: 0, sender: .patient)
        let item2 = TextMessageItem.mock(dateOffset: 1, sender: .patient)
        // WHEN
        let transformed = transform(items: [item1, item2], focusedTextItemId: item1.id)
        // THEN
        XCTRequireEqual(transformed.count, 4)
        XCTAssert(transformed[3] is DateSeparatorViewItem)
        XCTAssert(transformed[2] is TextMessageViewItem)
        XCTAssert(transformed[1] is DateSeparatorViewItem)
        XCTAssertEqual(item1.date, (transformed[1] as? DateSeparatorViewItem)?.date)
        XCTAssert(transformed[0] is TextMessageViewItem)
        XCTAssertEqual(true, (transformed[0] as? ConversationViewMessageItem)?.isFocused)
    }
}
