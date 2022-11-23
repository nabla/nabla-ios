import Foundation
import UIKit

struct ImageMessageContentViewModelTransformer {
    // MARK: - Public

    static func transform(item: ImageMessageViewItem) -> ImageMessageContentView.ContentViewModel {
        .init(
            originalImageSize: originalImageSize(from: item),
            imageSource: item.image.source
        )
    }

    // MARK: - Private

    private static func originalImageSize(from item: ImageMessageViewItem) -> CGSize? {
        guard
            let width = item.image.size?.width,
            let height = item.image.size?.height else {
            return nil
        }
        return CGSize(width: width, height: height)
    }
}
