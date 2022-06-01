import Foundation

struct DocumentMessageContentViewModelTransformer {
    // MARK: - Public

    static func transform(item: DocumentMessageViewItem) -> DocumentMessageContentView.ContentViewModel {
        .init(url: item.document.thumbnailUrl, filename: item.document.fileName)
    }
}
