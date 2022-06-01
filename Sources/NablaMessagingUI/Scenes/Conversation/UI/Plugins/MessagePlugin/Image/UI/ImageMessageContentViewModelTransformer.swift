import Foundation

struct ImageMessageContentViewModelTransformer {
    // MARK: - Public

    static func transform(item: ImageMessageViewItem) -> ImageMessageContentView.ContentViewModel {
        .init(url: item.image.fileUrl)
    }
}
