import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import UIKit
import XCTest

// swiftlint:disable force_unwrapping

final class ConversationMessagePreviewViewTests: XCTestCase {
    private let size = CGSize(width: 320, height: 70)
    private let provider = Provider.mock(prefix: "Dr", firstName: "John", lastName: "Doe")
    private var sut: ConversationMessagePreviewView!

    override func setUp() {
        super.setUp()
        sut = .init(frame: .zero)
    }

    func testConfigureReplyToTextMe() {
        // GIVEN
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: TextMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .me,
                sendingState: .sent,
                replyTo: nil,
                text: .loremStub
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!, sender: .me(isContiguous: true))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTextConfigureReplyToImageMe() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: ImageMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .me,
                sendingState: .sent,
                replyTo: nil,
                image: .mock
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!, sender: .me(isContiguous: true))
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }

    func testTextConfigureReplyToVideoMe() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: VideoMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .me,
                sendingState: .sent,
                replyTo: nil,
                video: .mock
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!, sender: .me(isContiguous: true))
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }

    func testTextConfigureReplyToDocumentMe() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: DocumentMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .me,
                sendingState: .sent,
                replyTo: nil,
                document: .mock
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!, sender: .me(isContiguous: true))
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }

    func testTextConfigureReplyToAudioMe() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: AudioMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .me,
                sendingState: .sent,
                replyTo: nil,
                audio: .mock
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!, sender: .me(isContiguous: true))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTextConfigureReplyToDeletedMe() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: DeletedMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .me,
                sendingState: .sent,
                replyTo: nil
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!, sender: .me(isContiguous: true))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTextConfigureReplyToTextThem() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: TextMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .provider(provider),
                sendingState: .sent,
                replyTo: nil,
                text: .loremStub
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(
            with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!,
            sender: ConversationMessageSenderTransformer.transform(item: item)
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTextConfigureReplyToImageThem() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: ImageMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .provider(provider),
                sendingState: .sent,
                replyTo: nil,
                image: .mock
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(
            with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!,
            sender: ConversationMessageSenderTransformer.transform(item: item)
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }

    func testTextConfigureReplyToDocumentThem() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: DocumentMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .provider(provider),
                sendingState: .sent,
                replyTo: nil,
                document: .mock
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(
            with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!,
            sender: ConversationMessageSenderTransformer.transform(item: item)
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }

    func testTextConfigureReplyToAudioThem() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: AudioMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .provider(provider),
                sendingState: .sent,
                replyTo: nil,
                audio: .mock
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(
            with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!,
            sender: ConversationMessageSenderTransformer.transform(item: item)
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTextConfigureReplyToDeletedThem() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: DeletedMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .provider(provider),
                sendingState: .sent,
                replyTo: nil
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(
            with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!,
            sender: ConversationMessageSenderTransformer.transform(item: item)
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testTextConfigureReplyToVideoThem() {
        let item = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: VideoMessageViewItem(
                id: UUID(),
                date: Date(),
                sender: .provider(provider),
                sendingState: .sent,
                replyTo: nil,
                video: .mock
            ),
            text: .loremStub
        )
        // WHEN
        sut.configure(
            with: ConversationMessagePreviewViewModelTransformer.transform(item: item.replyTo)!,
            sender: ConversationMessageSenderTransformer.transform(item: item)
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }
}
