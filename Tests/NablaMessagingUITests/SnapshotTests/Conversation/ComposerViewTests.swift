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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testComposerViewPlaceholder() {
        // GIVEN
        // WHEN
        sut.placeHolder = .placeholderStub
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testComposerViewText() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.text = "Text"
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    // TODO: (@ams) Check why the image is not loading even though we wait
    func testComposerViewAddMedia() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.add([ImageFile.mockWithInvalidUrl])
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: CGSize(width: 320, height: 200)))
    }

    func testComposerViewRecordAudio() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.audioRecorderComposerPresenterDidStartRecording(AudioRecorderComposerPresenterMock())
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: size))
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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 320, height: 200)))
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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: CGSize(width: 320, height: 200)))
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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: CGSize(width: 320, height: 200)))
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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: CGSize(width: 320, height: 200)))
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
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: CGSize(width: 320, height: 200)))
    }
}
