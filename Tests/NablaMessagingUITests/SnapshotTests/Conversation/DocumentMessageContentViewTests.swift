import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class DocumentMessageContentViewTests: XCTestCase {
    private let size = CGSize(width: 320, height: 200)
    private var sut: ConversationMessageCell<DocumentMessageContentView>!

    override func setUp() {
        super.setUp()
        sut = .init(frame: .zero)
    }

    func testDocumentConfigureMe() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .me(isContiguous: false),
                footer: nil,
                replyTo: nil,
                content: .init(url: .stub, filename: .filenameStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }

    func testDocumentConfigureThem() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .them(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(url: .stub, filename: .filenameStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 0.5, on: .image(size: size)))
    }
}
