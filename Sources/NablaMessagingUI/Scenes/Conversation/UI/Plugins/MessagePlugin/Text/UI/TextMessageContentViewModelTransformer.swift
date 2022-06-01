import Foundation

struct TextMessageContentViewModelTransformer {
    // MARK: - Public

    static func transform(item: TextMessageViewItem) -> TextMessageContentView.ContentViewModel {
        .init(text: item.text)
    }
}
