import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class ComposerViewTests: XCTestCase {
    private let size = CGSize(width: 320, height: 52)
    private var sut: ComposerView!

    override func setUp() {
        super.setUp()
        sut = .init()
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

    // TODO: (@ams) Check what the image is not loading even though we wait
    func testComposerViewAddMedia() {
        // GIVEN
        sut.placeHolder = .placeholderStub
        // WHEN
        sut.add([.mockImage])
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: CGSize(width: 320, height: 200))))
    }
}
