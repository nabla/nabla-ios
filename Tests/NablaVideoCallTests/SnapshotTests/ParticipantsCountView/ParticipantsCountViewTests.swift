import Foundation
import NablaCoreTestsUtils
@testable import NablaVideoCall
import SnapshotTesting
import XCTest

final class ParticipantsCountViewTests: XCTestCase {
    private var sut: ParticipantsCountView!
    
    override func setUp() {
        super.setUp()
        
        sut = ParticipantsCountView()
    }
    
    func testCorrectDeisgn() {
        // GIVEN
        // WHEN
        sut.text = "3"
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: CGSize(width: 58, height: 32)))
    }
}
