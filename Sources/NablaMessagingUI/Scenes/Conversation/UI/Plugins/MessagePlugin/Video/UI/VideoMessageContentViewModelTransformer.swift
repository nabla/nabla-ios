import Foundation
import UIKit

struct VideoMessageContentViewModelTransformer {
    // MARK: - Public

    static func transform(item: VideoMessageViewItem) -> VideoMessageContentView.ContentViewModel {
        .init(
            originalVideoSize: originalVideoSize(from: item),
            videoSource: item.video.content
        )
    }

    // MARK: - Private

    private static func originalVideoSize(from item: VideoMessageViewItem) -> CGSize? {
        guard
            let width = item.video.size?.width,
            let height = item.video.size?.height else {
            return nil
        }
        return CGSize(width: width, height: height)
    }
}
