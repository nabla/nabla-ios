import NablaCoreTestsUtils
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

class AudioRecorderComposerViewTests: XCTestCase {
    private let size = CGSize(width: 184, height: 44)
    private var sut: AudioRecorderComposerView!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
    
    func testDisplayDuration() {
        // GIVEN
        // WHEN
        sut.configure(with: .init(duration: "00:30"))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 3, size: size))
    }
}
