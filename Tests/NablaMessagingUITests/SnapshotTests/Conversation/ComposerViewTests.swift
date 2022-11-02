import NablaCoreTestsUtils
import NablaMessagingCore
import NablaMessagingCoreTestsUtils
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class ComposerViewTests: XCTestCase {
    private let size = CGSize(width: 320, height: 52)
    private var sut: ComposerView!

    override func setUp() {
        super.setUp()
        sut = .init(dependencies: .init(logger: LoggerMock()))
    }

    func testComposerViewInit() {
        // GIVEN
        // WHEN
        /* Init in the setup */
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testComposerViewPlaceholder() {
        // GIVEN
        // WHEN
        sut.placeHolder = .placeholderStub
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testComposerViewText() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.text = "Text"
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    // TODO: (@ams) Check why the image is not loading even though we wait
    func testComposerViewAddMedia() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.add([ImageFile.mock])
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: CGSize(width: 320, height: 200))))
    }

    func testComposerViewRecordAudio() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.audioRecorderComposerPresenterDidStartRecording(AudioRecorderComposerPresenterMock())
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }

    func testComposerViewReplyToText() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.replyToMessage = TextMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: nil,
            text: .loremStub
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 320, height: 200)))
    }

    func testComposerViewReplyToImage() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.replyToMessage = ImageMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: nil,
            image: .mock
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: CGSize(width: 320, height: 200))))
    }

    func testComposerViewReplyToDocument() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.replyToMessage = DocumentMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: nil,
            document: .mock
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: CGSize(width: 320, height: 200))))
    }

    func testComposerViewReplyToAudio() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.replyToMessage = AudioMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: nil,
            audio: .mock
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 320, height: 200)))
    }

    func testComposerViewReplyToVideo() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.replyToMessage = VideoMessageViewItem(
            id: UUID(),
            date: Date(),
            sender: .me,
            sendingState: .sent,
            replyTo: nil,
            video: .mock
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: CGSize(width: 320, height: 200)))
    }
}
