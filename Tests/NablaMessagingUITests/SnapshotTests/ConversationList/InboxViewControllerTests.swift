import NablaCoreTestsUtils
import NablaMessagingCore
import NablaMessagingCoreTestsUtils
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class InboxViewControllerTests: XCTestCase {
    private var navigationController: UINavigationController!
    private var conversationListView: ConversationListView!
    private var sut: InboxViewController!

    override func setUp() {
        super.setUp()
        sut = InboxViewController()
        conversationListView = ConversationListView(logger: LoggerMock())
        conversationListView.configure(with: .loaded(viewModel: .empty))
        sut.setContentView(conversationListView)
        navigationController = UINavigationController(rootViewController: sut)
    }

    func testInboxViewControllerEmptyConversationList() {
        // GIVEN
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }

    // FIXME: The presented AlertViewController is not captured in the snapshot
    func xtestInboxViewControllerWithErrorMessage() {
        // GIVEN
        // WHEN
        sut.display(error: "Error message")
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }

    func testInboxViewControllerEmptyListCreatingConversation() {
        // GIVEN
        // WHEN
        sut.set(loading: true)
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testInboxViewControllerIsRefreshing() {
        // GIVEN
        // WHEN
        conversationListView.configure(with: .loaded(viewModel: .init(items: [], isRefreshing: true)))
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testInboxViewControllerIsRefreshingWithLargeTitle() {
        // GIVEN
        navigationController.navigationBar.prefersLargeTitles = true
        // WHEN
        conversationListView.configure(with: .loaded(viewModel: .init(items: [], isRefreshing: true)))
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    /// This test makes sure that iOS will find the `UIScrollView` and will be able to adjust the navigation bar and tab bar according to its scroll offset.
    /// Since `SwiftSnapshotTesting` is not able to take a snapshot a the application with nested `UINavigationController` and `UITabBarController` correctly,
    /// this test replicates how the system will look for the `UIScrollView` and checks that it can be found.
    func testInboxViewControllerIntegratedInNavigation() {
        // GIVEN
        // WHEN
        var firstView = sut.view
        while let firstSubview = firstView?.subviews.first {
            firstView = firstSubview
            if firstView is UIScrollView {
                break
            }
        }
        // THEN
        XCTAssert(firstView is UIScrollView)
    }
}
