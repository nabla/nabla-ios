import NablaCoreTestsUtils
import NablaMessagingCore
import NablaMessagingCoreTestsUtils
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class InboxViewControllerTests: XCTestCase {
    private var navigationController: UINavigationController!
    private var sut: InboxViewController!

    override func setUp() {
        super.setUp()
        sut = InboxViewController()
        let conversationListView = ConversationListView()
        conversationListView.configure(with: .loaded(viewModel: .empty))
        sut.setContentView(conversationListView)
        navigationController = UINavigationController(rootViewController: sut)
    }

    func testInboxViewControllerEmpty() {
        // GIVEN
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }

    func testInboxViewControllerWithErrorMessage() {
        // GIVEN
        // WHEN
        sut.display(error: "Error message")
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }

    func testInboxViewControllerLoading() {
        // GIVEN
        // WHEN
        sut.set(loading: true)
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
}
