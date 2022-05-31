import Foundation
import NablaMessagingCore

struct MediaComposerItemViewModelMapper {
    func map(medias: [Media]) -> [MediaComposerItemViewModel] {
        medias.compactMap { media in
            guard let type = media.viewModelType else { return nil }
            return MediaComposerItemViewModel(url: media.fileUrl, type: type)
        }
    }
}

private extension Media {
    var viewModelType: MediaComposerItemViewModel.MediaType? {
        switch type {
        case .video, .audio:
            return nil
        case .pdf:
            return .pdf
        case .image:
            return .image
        }
    }
}
