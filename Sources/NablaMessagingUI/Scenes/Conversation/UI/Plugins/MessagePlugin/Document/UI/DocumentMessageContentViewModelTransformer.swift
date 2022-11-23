import Foundation

struct DocumentMessageContentViewModelTransformer {
    // MARK: - Public

    static func transform(item: DocumentMessageViewItem) -> DocumentMessageContentView.ContentViewModel {
        .init(thumbnail: item.document.thumbnail, filename: item.document.fileName)
    }
}
