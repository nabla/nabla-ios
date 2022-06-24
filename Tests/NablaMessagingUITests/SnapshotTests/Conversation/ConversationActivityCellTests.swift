import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class ConversationActivityCellTests: XCTestCase {
    private let size = CGSize(width: 320, height: 88)
    private var sut: ConversationActivityCell!

    override func setUp() {
        super.setUp()
        sut = ConversationActivityCell(frame: .zero)
    }

    func testConfigureWithText() {
        // GIVEN
        // WHEN
        sut.configure(with: .init(text: "Dr John Doe a rejoint la conversation"))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testConfigureWithTextOnTwoLines() {
        // GIVEN
        // WHEN
        sut.configure(with: .init(text: "Dr John Doe a rejoint la conversation en retard comme d'habitude"))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testConfigureWithLongText() {
        // GIVEN
        // WHEN
        sut.configure(with: .init(text: "Dr John Doe a rejoint la conversation en retard comme d'habitude et on a dû l'attendre 30 minutes"))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
