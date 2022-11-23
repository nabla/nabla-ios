import Foundation
import NablaMessagingCore

struct ImageDetailViewModelTransformer {
    // MARK: - Public

    func transform(image: ImageFile) -> ImageDetailViewModel {
        ImageDetailViewModel(
            fileName: image.fileName,
            image: image.source
        )
    }
}
