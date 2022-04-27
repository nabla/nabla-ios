import Foundation
import NablaCore

struct ImageDetailViewModelMapper {
    func map(media: Media) -> ImageDetailViewModel {
        ImageDetailViewModel(url: media.fileUrl)
    }
}
