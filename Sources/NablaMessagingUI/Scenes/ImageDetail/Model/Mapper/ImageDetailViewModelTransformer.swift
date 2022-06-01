import Foundation
import NablaMessagingCore

struct ImageDetailViewModelTransformer {
    // MARK: - Public

    func transform(media: Media) -> ImageDetailViewModel {
        ImageDetailViewModel(url: media.fileUrl)
    }
}
