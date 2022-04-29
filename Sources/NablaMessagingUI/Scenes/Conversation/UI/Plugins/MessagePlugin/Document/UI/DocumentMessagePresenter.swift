import Foundation

final class DocumentMessagePresenter:
    MessagePresenter<
        DocumentMessageContentView,
        DocumentMessageViewItem,
        ConversationMessageCell<DocumentMessageContentView>
    > {
    // MARK: - Init
    
    init(
        delegate: ConversationCellPresenterDelegate,
        item: DocumentMessageViewItem,
        conversationId: UUID
    ) {
        self.delegate = delegate
        super.init(
            delegate: delegate,
            item: item,
            conversationId: conversationId,
            transformContent: Self.transform
        )
    }
    
    override func userDidTapContent() {
        delegate?.didTapMedia(item.document)
    }
    
    // MARK: - Private
    
    private weak var delegate: ConversationCellPresenterDelegate?
    
    private static func transform(item: DocumentMessageViewItem) -> DocumentMessageContentView.ContentViewModel {
        .init(url: item.document.thumbnailUrl, filename: item.document.fileName)
    }
}
