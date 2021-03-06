import NablaCoreTestsUtils
import NablaMessagingCore
import NablaMessagingCoreTestsUtils
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class ConversationViewControllerTests: XCTestCase {
    private let size = ViewImageConfig.iPhoneX.size
    private var sut: ConversationViewController!

    override func setUp() {
        super.setUp()
        sut = ConversationViewController.create(
            conversationId: UUID(),
            showComposer: true,
            client: NablaMessagingClientProtocolMock(),
            logger: LoggerMock()
        )
        sut.presenter = ConversationPresenterMock()
    }

    func testConversationVCConfigureWithLoading() {
        // GIVEN
        // WHEN
        sut.configure(withState: .loading)
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testConversationVCConfigureWithEmpty() {
        // GIVEN
        // WHEN
        sut.configure(withState: .loaded(items: []))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testConversationVCConfigureWithEmptyAndNoComposer() {
        // GIVEN
        sut = ConversationViewController.create(
            conversationId: UUID(),
            showComposer: false,
            client: NablaMessagingClientProtocolMock(),
            logger: LoggerMock()
        )
        sut.presenter = ConversationPresenterMock()
        // WHEN
        sut.configure(withState: .loaded(items: []))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testConversationVCConfigureWithError() {
        // GIVEN
        // WHEN
        sut.configure(withState: .error(viewModel: .init(message: "Error Message 🤷‍♂️", buttonTitle: nil)))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testConversationVCConfigureWithErrorAndRetry() {
        // GIVEN
        // WHEN
        sut.configure(withState: .error(viewModel: .init(message: "Error Message 🤷‍♂️", buttonTitle: "Retry")))
        // THEN
        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testConversationVCConfigureWithLoadedItems() {
        // GIVEN
        let provider = Provider.mock(prefix: "Dr", firstName: "John", lastName: "Doe")
        // WHEN
        sut.configure(withState: .loaded(items: [
            ConversationActivityViewItem(id: UUID(), date: Date(), activity: .providerJoined(.deletedProvider)),
            ConversationActivityViewItem(id: UUID(), date: Date(), activity: .providerJoined(.provider(provider))),
            DeletedMessageViewItem(id: UUID(), date: Date(), sender: .system(.mock()), sendingState: .toBeSent, replyTo: nil),
            DocumentMessageViewItem(id: UUID(), date: Date(), sender: .provider(provider), sendingState: .sent, replyTo: nil, document: .mock),
            DateSeparatorViewItem(id: UUID(), date: Date(timeIntervalSince1970: 0)),
            TextMessageViewItem(id: UUID(), date: Date(), sender: .patient, sendingState: .failed, replyTo: nil, text: .loremStub),
            TypingIndicatorViewItem(sender: .provider(provider)),
            AudioMessageViewItem(id: UUID(), date: Date(), sender: .provider(provider), sendingState: .sent, replyTo: nil, audio: .mock),
            HasMoreIndicatorViewItem(),
        ]))
        // THEN
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image(size: size)))
    }
}
