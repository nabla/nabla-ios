import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import UIKit
import XCTest

final class TextMessageContentViewTests: XCTestCase {
    private let size = CGSize(width: 375, height: 160)
    private var sut: ConversationMessageCell<TextMessageContentView>!

    override func setUp() {
        super.setUp()
        sut = .init(frame: .zero)
    }

    func testTextConfigureMe() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(text: .loremStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTextConfigureMeContiguous() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: true),
                footer: nil,
                replyTo: nil,
                content: .init(text: .loremStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTextConfigureThemContiguous() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .loremStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTextConfigureThem() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: true)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .loremStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testTextConfigureMeWithLink() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(text: .textWithLinksStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image(size: size)))
    }
    
    func testTextConfigureThemWithLink() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .textWithLinksStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image(size: size)))
    }
    
    func testTextConfigureMeWithPhoneNumber() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(text: .textWithPhoneNumbersStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image(size: size)))
    }
    
    func testTextConfigureThemWithPhoneNumber() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .textWithPhoneNumbersStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image(size: size)))
    }
}
