import Foundation
import NablaMessagingCore
import UIKit

final class TextMessagePresenter:
    MessagePresenter<
        TextMessageContentView,
        TextMessageViewItem,
        ConversationMessageCell<TextMessageContentView>
    > {
    // MARK: - Init
    
    init(
        item: TextMessageViewItem,
        conversationId: UUID,
        client: NablaMessagingClient,
        delegate: ConversationCellPresenterDelegate
    ) {
        super.init(
            item: item,
            conversationId: conversationId,
            client: client,
            delegate: delegate,
            transformContent: Self.transform
        )
    }

    override func makeMenuElements(_ item: TextMessageViewItem) -> [UIMenuElement] {
        let menuElements = super.makeMenuElements(item)
        let copyAction = UIAction(
            title: L10n.conversationActionCopy,
            image: UIImage(systemName: "doc.on.doc"),
            handler: { _ in UIPasteboard.general.string = item.text }
        )
        return [copyAction] + menuElements
    }

    // MARK: - Private
    
    // TODO: - Move the transform to a separate class ?
    private static func transform(item: TextMessageViewItem) -> TextMessageContentView.ContentViewModel {
        .init(text: item.text)
    }
}
