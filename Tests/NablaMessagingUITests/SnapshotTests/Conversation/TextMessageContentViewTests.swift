import NablaCoreTestsUtils
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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testTextConfigureProviderContiguous() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .loremStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testTextConfigureProvider() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: true)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .loremStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
    
    func testTextConfigureOtherContiguous() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .loremStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testTextConfigureOther() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: true)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .loremStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 1, size: size))
    }
    
    func testTextConfigureProviderWithLink() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .textWithLinksStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 1, size: size))
    }
    
    func testTextConfigureOtherWithLink() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(text: .textWithLinksStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 1, size: size))
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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 1, size: size))
    }
    
    func testTextConfigureProviderWithPhoneNumber() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(
                    .init(
                        author: .authorStub,
                        avatar: .init(url: nil, text: .initialsStub),
                        isContiguous: false
                    )
                ),
                footer: nil,
                replyTo: nil,
                content: .init(text: .textWithPhoneNumbersStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 1, size: size))
    }
    
    func testTextConfigureOtherWithPhoneNumber() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(
                    .init(
                        author: .otherAuthorStub,
                        avatar: .init(url: nil, text: .otherInitialsStub),
                        isContiguous: false
                    )
                ),
                footer: nil,
                replyTo: nil,
                content: .init(text: .textWithPhoneNumbersStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 1, size: size))
    }
    
    func testTextConfigureMeInResponseToMessageWithLongerOriginal() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: .init(
                    icon: nil,
                    author: .authorStub,
                    text: "Text much longer than the response",
                    image: nil
                ),
                content: .init(text: "Sure"),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
    
    func testTextConfigureMeInResponseToMessageWithLongerMessage() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: .init(
                    icon: nil,
                    author: .authorStub,
                    text: "What?",
                    image: nil
                ),
                content: .init(text: "Text much longer than the original message and ignoring the question"),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
}
