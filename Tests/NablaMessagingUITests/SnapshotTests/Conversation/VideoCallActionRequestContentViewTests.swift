import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import UIKit
import XCTest

final class VideoCallActionRequestContentViewTests: XCTestCase {
    private let size = CGSize(width: 375, height: 160)
    private var sut: ConversationMessageCell<VideoCallActionRequestContentView>!

    override func setUp() {
        super.setUp()
        sut = .init(frame: .zero)
    }

    func testConfigureMeWaiting() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(state: .waiting),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testConfigureProviderWaiting() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(state: .waiting),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testConfigureOtherWaiting() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(state: .waiting),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testConfigureMeOpened() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(state: .opened),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testConfigureProviderOpened() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(state: .opened),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testConfigureOtherOpened() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(state: .opened),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testConfigureMeClosed() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(state: .closed),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testConfigureProviderClosed() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(state: .closed),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testConfigureOtherClosed() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(state: .closed),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
