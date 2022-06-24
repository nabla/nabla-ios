import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class ConversationDateSeparatorCellTests: XCTestCase {
    private let size = CGSize(width: 320, height: 88)
    private var sut: DateSeparatorCell!

    override func setUp() {
        super.setUp()
        sut = DateSeparatorCell(frame: .zero)
    }

    func testConfigureWithDate() {
        // GIVEN
        // WHEN
        sut.configure(with: .init(text: "Le 03/03/2033 à 03:03"))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testConfigureWithSuperLongDate() {
        // GIVEN
        // WHEN
        sut.configure(with: .init(text: "Hier en fin de matinée vers 19h30 après le retour des enfants de l'école."))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
