import NablaCoreTestsUtils
import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class VideoMessageContentViewTests: XCTestCase {
    private let size = CGSize(width: 340, height: 260)
    private var sut: ConversationMessageCell<VideoMessageContentView>!

    override func setUp() {
        super.setUp()
        sut = .init(frame: .zero)
    }

    // TODO: Fix AVPlayerController rendring inconsistencies
    func skip_testVideoConfigureMe() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(originalVideoSize: .init(width: 700, height: 394), videoSource: .url(.stubInvalidVideo)),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: size))
    }

    // TODO: Fix AVPlayerController rendring inconsistencies
    func skip_testVideoConfigureProvider() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(originalVideoSize: .init(width: 700, height: 394), videoSource: .url(.stubInvalidVideo)),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: size))
    }
    
    // TODO: Fix AVPlayerController rendring inconsistencies
    func skip_testVideoConfigureOther() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(originalVideoSize: .init(width: 700, height: 394), videoSource: .url(.stubInvalidVideo)),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: size))
    }
}
