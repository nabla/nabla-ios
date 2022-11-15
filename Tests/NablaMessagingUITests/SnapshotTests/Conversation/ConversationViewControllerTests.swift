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
            client: NablaMessagingClientProtocolMock(),
            logger: LoggerMock(),
            videoCallClient: nil,
            delegate: nil
        )
        sut.presenter = ConversationPresenterMock()
    }

    func testConversationVCConfigureWithLoading() {
        // GIVEN
        // WHEN
        sut.configure(withState: .loading)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testConversationVCConfigureWithEmpty() {
        // GIVEN
        // WHEN
        sut.configure(withState: .loaded(items: [], showComposer: true))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testConversationVCConfigureWithEmptyAndNoComposer() {
        // GIVEN
        sut = ConversationViewController.create(
            conversationId: UUID(),
            client: NablaMessagingClientProtocolMock(),
            logger: LoggerMock(),
            videoCallClient: nil,
            delegate: nil
        )
        sut.presenter = ConversationPresenterMock()
        // WHEN
        sut.configure(withState: .loaded(items: [], showComposer: false))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testConversationVCConfigureWithError() {
        // GIVEN
        // WHEN
        sut.configure(withState: .error(viewModel: .init(message: "Error Message 🤷‍♂️", buttonTitle: nil)))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    func testConversationVCConfigureWithErrorAndRetry() {
        // GIVEN
        // WHEN
        sut.configure(withState: .error(viewModel: .init(message: "Error Message 🤷‍♂️", buttonTitle: "Retry")))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }

    // TODO: (@ams) Check why the image is not loading even though we wait
    func testConversationVCConfigureWithLoadedItems() {
        // GIVEN
        let provider = Provider.mock(prefix: "Dr", firstName: "John", lastName: "Doe")
        sut.view.layoutIfNeeded()
        // WHEN
        sut.configure(withState: .loaded(items: [
            HasMoreIndicatorViewItem(),
            AudioMessageViewItem(id: UUID(), date: Date(), sender: .provider(provider), sendingState: .sent, replyTo: nil, audio: .mock),
            TypingIndicatorViewItem(sender: .provider(provider)),
            TextMessageViewItem(id: UUID(), date: Date(), sender: .me, sendingState: .failed, replyTo: nil, text: .loremStub),
            DateSeparatorViewItem(id: UUID(), date: Date(timeIntervalSince1970: 0)),
            DocumentMessageViewItem(id: UUID(), date: Date(), sender: .provider(provider), sendingState: .sent, replyTo: nil, document: .mockWithInvalidUrl),
            DeletedMessageViewItem(id: UUID(), date: Date(), sender: .system(.mock()), sendingState: .sent, replyTo: nil),
            ConversationActivityViewItem(id: UUID(), date: Date(), activity: .providerJoined(.provider(provider))),
            ConversationActivityViewItem(id: UUID(), date: Date(), activity: .providerJoined(.deletedProvider)),
        ], showComposer: true))
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(wait: 1, size: size))
    }
}
