import Foundation
import NablaMessagingCore

struct MediaComposerItemViewModelTransformer {
    // MARK: - Public

    func transform(medias: [Media]) -> [MediaComposerItemViewModel] {
        medias.compactMap { media in
            guard let type = media.viewModelType else { return nil }
            return MediaComposerItemViewModel(
                mediaSource: MediaContentTransformer.transform(media.content),
                type: type
            )
        }
    }
}

private extension Media {
    var viewModelType: MediaComposerItemViewModel.MediaType? {
        if self is DocumentFile {
            return .pdf
        } else if self is ImageFile {
            return .image
        } else if self is VideoFile {
            return .video
        }
        return nil
    }
}
