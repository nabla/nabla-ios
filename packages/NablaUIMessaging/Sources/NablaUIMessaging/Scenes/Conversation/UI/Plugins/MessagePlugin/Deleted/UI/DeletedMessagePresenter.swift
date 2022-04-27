import Foundation
import UIKit

final class DeletedMessagePresenter:
    MessagePresenter<
        DeletedMessageContentView,
        DeletedMessageViewItem,
        ConversationMessageCell<DeletedMessageContentView>
    > {
    // MARK: - Init

    init(
        delegate: ConversationCellPresenterDelegate,
        item: DeletedMessageViewItem,
        conversationId: UUID
    ) {
        super.init(
            delegate: delegate,
            item: item,
            conversationId: conversationId,
            transformContent: Self.transform
        )
    }

    // MARK: - Internal

    override func makeMenuElements(_: DeletedMessageViewItem) -> [UIMenuElement] {
        []
    }

    // MARK: - Private

    // TODO: - Move the transform to a separate class ?
    private static func transform(_: DeletedMessageViewItem) -> DeletedMessageContentView.ContentViewModel {
        .init(text: L10n.conversationDeletedMessage)
    }
}
