import Foundation
import NablaCore
import NablaMessagingCore
import UIKit

final class VideoCallActionRequestPresenter:
    MessagePresenter<
        VideoCallActionRequestContentView,
        VideoCallActionRequestViewItem,
        ConversationMessageCell<VideoCallActionRequestContentView>
    >
{
    // MARK: - Internal
    
    override var item: VideoCallActionRequestViewItem {
        didSet { update() }
    }
    
    // MARK: - Init
    
    init(
        logger: Logger,
        item: VideoCallActionRequestViewItem,
        conversationId: UUID,
        client: NablaMessagingClientProtocol,
        videoCallClient: VideoCallClient,
        delegate: ConversationCellPresenterDelegate
    ) {
        super.init(
            logger: logger,
            item: item,
            conversationId: conversationId,
            client: client,
            delegate: delegate,
            transformContent: Self.makeTransformer(videoCallClient: videoCallClient)
        )
        
        watchCurrentCallSubscription = videoCallClient.watchCurrentVideoCall { [weak self] currentVideoCallToken in
            self?.updateCallState(currentVideoCallToken: currentVideoCallToken)
        }
    }
    
    func userDidTapJoinRoomButton() {
        guard let room = item.room else { return }
        delegate?.didTapJoinVideoCall(url: room.url, token: room.token)
    }
    
    func updateCallState(currentVideoCallToken: String?) {
        guard let room = item.room else { return }
        let isCallInProgress = room.token == currentVideoCallToken
        let viewModel = VideoCallActionRequestContentViewModelTransformer.transform(item: item, isCallInProgress: isCallInProgress)
        view?.content.configure(with: viewModel)
    }
    
    // MARK: - Private
    
    private var watchCurrentCallSubscription: Cancellable?
    
    private typealias Transformer = (VideoCallActionRequestViewItem) -> VideoCallActionRequestContentView.ContentViewModel
    private static func makeTransformer(videoCallClient: VideoCallClient) -> Transformer {
        { item in
            VideoCallActionRequestContentViewModelTransformer.transform(item: item, isCallInProgress: videoCallClient.currentVideoCallToken != nil)
        }
    }
    
    private func update() {
        updateView()
    }
}
