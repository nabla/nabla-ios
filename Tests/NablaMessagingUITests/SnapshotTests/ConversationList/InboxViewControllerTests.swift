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
        assertSnapshot(matching: navigationController, as: .image(size: ViewImageConfig.iPhoneSe.size))
    }

    func testInboxViewControllerWithErrorMessage() {
        // GIVEN
        // WHEN
        sut.display(error: "Error message")
        // THEN
        assertSnapshot(matching: navigationController, as: .image(size: ViewImageConfig.iPhoneSe.size))
    }

    func testInboxViewControllerLoading() {
        // GIVEN
        // WHEN
        sut.set(loading: true)
        // THEN
        assertSnapshot(matching: navigationController, as: .image(size: ViewImageConfig.iPhoneSe.size))
    }
}
