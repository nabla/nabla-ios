import Foundation

struct DeletedMessageContentViewModelTransformer {
    // MARK: - Public

    static func transform(_: DeletedMessageViewItem) -> DeletedMessageContentView.ContentViewModel {
        .init(text: L10n.conversationDeletedMessage)
    }
}
