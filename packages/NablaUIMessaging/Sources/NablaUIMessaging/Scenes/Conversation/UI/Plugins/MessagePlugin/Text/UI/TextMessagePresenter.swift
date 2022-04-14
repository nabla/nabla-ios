import Foundation

final class TextMessagePresenter:
    MessagePresenter<
        TextMessageContentView,
        TextMessageItemContent,
        ConversationMessageCell<TextMessageContentView>
    > {
    // MARK: - Init

    init(
        delegate: ConversationCellPresenterDelegate,
        id: UUID,
        content: TextMessageItemContent
    ) {
        super.init(
            delegate: delegate,
            id: id,
            content: content,
            transform: Self.transform
        )
    }

    // MARK: - Private

    // TODO: - Move the transform to a separate class ?
    private static func transform(textMessageItemContent: TextMessageItemContent)
        -> ConversationMessageViewModel<TextMessageContentView.ContentViewModel> {
        .init(
            //            sender: .them(.init(author: "Dr. John Doe", avatar: .init(url: nil, text: "JD"), displaySenderNameAndAvatar: true)),
            sender: .me,
            footer: nil,
            content: .init(
                text: textMessageItemContent.text
            )
        )
    }
}
