import NablaMessagingCore
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class ConversationListViewTests: XCTestCase {
    private let item: ConversationListItemViewModel = .init(
        avatar: .init(url: nil, text: "JD"),
        title: "Dr John Doe",
        lastMessage: "How are you?",
        lastUpdatedTime: "Today",
        isUnread: true
    )
    private var sut: ConversationListView!

    override func setUp() {
        super.setUp()
        sut = ConversationListView(frame: .zero)
    }

    func testConversationLVConfigureWithLoading() {
        // GIVEN
        // WHEN
        sut.configure(with: .loading)
        // THEN
        assertSnapshot(matching: sut, as: .image(size: ViewImageConfig.iPhoneSe.size))
    }
    
    func testConversationLVConfigureWithErrorMessage() {
        // GIVEN
        // WHEN
        sut.configure(with: .error(.init(message: "Error Message 🤷‍♂️", buttonTitle: nil)))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: ViewImageConfig.iPhoneSe.size))
    }
    
    func testConversationLVConfigureWithErrorMessageAndRetryTitle() {
        // GIVEN
        // WHEN
        sut.configure(with: .error(.init(message: "Error Message 🤷‍♂️", buttonTitle: "Retry")))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: ViewImageConfig.iPhoneSe.size))
    }
    
    func testConversationLVConfigureWithLoadedNoItems() {
        // GIVEN
        // WHEN
        sut.configure(with: .loaded(viewModel: .init(items: [])))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: ViewImageConfig.iPhoneSe.size))
    }
    
    func testConversationLVConfigureWithLoadedItems() {
        // GIVEN
        // WHEN
        sut.configure(with: .loaded(viewModel: .init(items: [item])))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: ViewImageConfig.iPhoneSe.size))
    }

    func testConversationLVDisplayLoadingMore() {
        // GIVEN
        sut.configure(with: .loaded(viewModel: .init(items: [item])))
        // WHEN
        sut.displayLoadingMore()
        // THEN
        assertSnapshot(matching: sut, as: .image(size: ViewImageConfig.iPhoneSe.size))
    }
}
