import Foundation
import NablaMessagingCore

struct ImageDetailViewModelMapper {
    func map(media: Media) -> ImageDetailViewModel {
        ImageDetailViewModel(url: media.fileUrl)
    }
}
