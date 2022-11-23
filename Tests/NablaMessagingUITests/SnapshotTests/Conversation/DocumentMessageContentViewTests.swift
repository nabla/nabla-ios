import NablaCoreTestsUtils
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
                content: .init(thumbnail: .stubLocalImage, filename: .filenameStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: size))
    }

    func testDocumentConfigureProvider() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .provider(.init(author: .authorStub, avatar: .init(url: nil, text: .initialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(thumbnail: .stubLocalImage, filename: .filenameStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: size))
    }
    
    func testDocumentConfigureOther() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                sender: .other(.init(author: .otherAuthorStub, avatar: .init(url: nil, text: .otherInitialsStub), isContiguous: false)),
                footer: nil,
                replyTo: nil,
                content: .init(thumbnail: .stubLocalImage, filename: .filenameStub),
                menuElements: []
            )
        )
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 0.5, size: size))
    }
}
