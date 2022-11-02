@testable import NablaMessagingCore
@testable import NablaMessagingCoreTestsUtils
@testable import NablaMessagingUI
import XCTest

class ConversationListViewModelTransformerTests: XCTestCase {
    private var sut: ConversationListViewModelTransformer!

    override func setUp() {
        super.setUp()
        sut = .init()
    }

    func testConversationPictureIsDisplayedInsteadOfProviderAvatar() {
        // GIVEN
        let conversation = Conversation.mock(
            pictureUrl: URL.stubImage,
            providers: [
                .init(
                    provider: .mock(avatarUrl: "http://some.other.url.com/image.jpg"),
                    typingAt: nil,
                    seenUntil: nil
                ),
            ]
        )
        // WHEN
        let result = sut.transform(conversation: conversation)
        // THEN
        XCTAssertEqual(result.avatar.url, URL.stubImage.absoluteString)
    }
    
    func testProviderAvatarIsDisplayedWhenThereIsNoConversationPicture() {
        // GIVEN
        let conversation = Conversation.mock(
            pictureUrl: nil,
            providers: [
                .init(
                    provider: .mock(avatarUrl: "http://some.other.url.com/image.jpg"),
                    typingAt: nil,
                    seenUntil: nil
                ),
            ]
        )
        // WHEN
        let result = sut.transform(conversation: conversation)
        // THEN
        XCTAssertEqual(result.avatar.url, "http://some.other.url.com/image.jpg")
    }
}
