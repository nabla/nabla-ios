import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class AudioMessageContentViewTests: XCTestCase {
    private let size = CGSize(width: 320, height: 200)
    private var sut: ConversationMessageCell<AudioMessageContentView>!

    override func setUp() {
        super.setUp()
        sut = .init(frame: .zero)
    }

    func testAudioConfigureMe() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(isPlayling: false, duration: "00:10"),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testAudioConfigureThem() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(isPlayling: false, duration: "00:07"),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
