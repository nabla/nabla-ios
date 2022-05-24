import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class DeletedMessageContentViewTests: XCTestCase {
    private let size = CGSize(width: 320, height: 88)
    private var sut: ConversationMessageCell<DeletedMessageContentView>!

    override func setUp() {
        super.setUp()
        sut = .init(frame: .zero)
    }

    func testDeletedConfigureMe() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                content: .init(text: "Message supprimé"),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testDeletedConfigureThem() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                content: .init(text: "Deleted Message"),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
