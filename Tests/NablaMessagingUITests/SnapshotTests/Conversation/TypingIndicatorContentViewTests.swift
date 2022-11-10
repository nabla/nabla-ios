import NablaCoreTestsUtils
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

    func testTypingIndicatorConfigureProvider() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: (),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
    
    func testTypingIndicatorConfigureOther() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: (),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testTypingIndicatorConfigureProviderContiguous() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: true)),
                footer: nil,
                replyTo: nil,
                content: (),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
    
    func testTypingIndicatorConfigureOtherContiguous() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: true)),
                footer: nil,
                replyTo: nil,
                content: (),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
}
