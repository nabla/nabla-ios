import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import UIKit
import XCTest

final class ConversationListItemCellTests: XCTestCase {
    private let size = CGSize(width: 320, height: 77)
    private var sut: ConversationListItemCell!

    override func setUp() {
        super.setUp()
        sut = ConversationListItemCell(style: .default, reuseIdentifier: nil)
    }

    func testConfigureWithMinimalItem() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                avatar: .init(url: nil, text: .initialsStub),
                title: .authorStub,
                lastMessage: nil,
                lastUpdatedTime: "Never",
                isUnread: false
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testConfigureWithFullItem() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                avatar: .init(url: .urlStub, text: nil),
                title: .authorStub,
                lastMessage: "Last message preview as a subtitle",
                lastUpdatedTime: "5min ago",
                isUnread: true
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image(size: size)))
    }
    
    func testConfigureWithLongTitle() {
        // GIVEN
        // WHEN
        sut.configure(
            with: .init(
                avatar: .init(url: nil, text: .initialsStub),
                title: "Chief Doctor John Doe",
                lastMessage: nil,
                lastUpdatedTime: "Sometime long ago",
                isUnread: false
            )
        )
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
