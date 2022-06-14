import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import UIKit
import XCTest

final class TypingIndicatorContentViewTests: XCTestCase {
    private let size = CGSize(width: 320, height: 80)
    private var sut: ConversationMessageCell<TypingIndicatorContentView>!

    override func setUp() {
        super.setUp()
        sut = .init(frame: .zero)
    }

    func testTypingIndicatorConfigureThem() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: (),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTypingIndicatorConfigureThemContiguous() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: true)),
                footer: nil,
                replyTo: nil,
                content: (),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
