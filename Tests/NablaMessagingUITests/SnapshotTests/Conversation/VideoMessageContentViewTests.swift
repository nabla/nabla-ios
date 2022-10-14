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

    func testVideoConfigureMe() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(originalVideoSize: .init(width: 700, height: 394), videoSource: .url(.stubVideo)),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }

    func testVideoConfigureThem() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(originalVideoSize: .init(width: 700, height: 394), videoSource: .url(.stubVideo)),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }
}
