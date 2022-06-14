import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class ImageMessageContentViewTests: XCTestCase {
    private let size = CGSize(width: 320, height: 260)
    private var sut: ConversationMessageCell<ImageMessageContentView>!

    override func setUp() {
        super.setUp()
        sut = .init(frame: .zero)
    }

    func testImageConfigureMe() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(url: .stub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }

    func testImageConfigureThem() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(url: .stub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }
}
