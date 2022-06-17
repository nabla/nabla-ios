import Foundation
import NablaMessagingCore

struct MediaComposerItemViewModelTransformer {
    // MARK: - Public

    func transform(medias: [Media]) -> [MediaComposerItemViewModel] {
        medias.compactMap { media in
            guard let type = media.viewModelType else { return nil }
            return MediaComposerItemViewModel(url: media.fileUrl, type: type)
        }
    }
}

private extension Media {
    var viewModelType: MediaComposerItemViewModel.MediaType? {
        switch type {
        case .audio:
            return nil
        case .pdf:
            return .pdf
        case .image:
            return .image
        case .video:
            return .video
        }
    }
}
