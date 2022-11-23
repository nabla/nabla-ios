import Foundation
import NablaMessagingCore

struct MediaComposerItemViewModelTransformer {
    // MARK: - Public

    func transform(medias: [Media]) -> [MediaComposerItemViewModel] {
        medias.compactMap { media in
            guard let type = media.viewModelType else { return nil }
            return MediaComposerItemViewModel(type: type)
        }
    }
}

private extension Media {
    var viewModelType: MediaComposerItemViewModel.MediaType? {
        if self is DocumentFile {
            return .pdf
        } else if let imageFile = self as? ImageFile {
            return .image(source: imageFile.source)
        } else if let videoFile = self as? VideoFile {
            return .video(source: videoFile.content)
        }
        return nil
    }
}
