import NablaCoreTestsUtils
import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class ConversationListViewTests: XCTestCase {
    private let item: ConversationListItemViewModel = .init(
        id: .init(),
        avatar: .init(url: nil, text: "JD"),
        title: "Dr John Doe",
        subtitle: "How are you?",
        lastUpdatedTime: "Today",
        isUnread: true
    )
    private var sut: ConversationListView!

    override func setUp() {
        super.setUp()
        sut = ConversationListView(logger: LoggerMock())
    }

    func testConversationLVConfigureWithLoading() {
        // GIVEN
        // WHEN
        sut.configure(with: .loading)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: ViewImageConfig.iPhoneSe.size))
    }
    
    func testConversationLVConfigureWithErrorMessage() {
        // GIVEN
        // WHEN
        sut.configure(with: .error(.init(message: "Error Message 🤷‍♂️", buttonTitle: nil)))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: ViewImageConfig.iPhoneSe.size))
    }
    
    func testConversationLVConfigureWithErrorMessageAndRetryTitle() {
        // GIVEN
        // WHEN
        sut.configure(with: .error(.init(message: "Error Message 🤷‍♂️", buttonTitle: "Retry")))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: ViewImageConfig.iPhoneSe.size))
    }
    
    func testConversationLVConfigureWithLoadedNoItems() {
        // GIVEN
        // WHEN
        sut.configure(with: .loaded(viewModel: .init(items: [], isRefreshing: false)))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: ViewImageConfig.iPhoneSe.size))
    }
    
    func testConversationLVConfigureWithLoadedItems() {
        // GIVEN
        // WHEN
        sut.configure(with: .loaded(viewModel: .init(items: [item], isRefreshing: true)))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: ViewImageConfig.iPhoneSe.size))
    }

    func testConversationLVDisplayLoadingMore() {
        // GIVEN
        sut.configure(with: .loaded(viewModel: .init(items: [item], isRefreshing: false)))
        // WHEN
        sut.displayLoadingMore()
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: ViewImageConfig.iPhoneSe.size))
    }
}
