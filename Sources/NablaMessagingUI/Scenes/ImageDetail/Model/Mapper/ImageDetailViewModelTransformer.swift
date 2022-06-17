import Foundation
import NablaMessagingCore

struct ImageDetailViewModelTransformer {
    // MARK: - Public

    func transform(image: ImageFile) -> ImageDetailViewModel {
        ImageDetailViewModel(url: image.fileUrl)
    }
}
