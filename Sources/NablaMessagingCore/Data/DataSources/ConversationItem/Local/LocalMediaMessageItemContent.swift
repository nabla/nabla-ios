import Foundation

enum LocalMediaMessageItemContent {
    case media(Media)
    case uploadedMedia(UploadedMedia)
    case audioFile(AudioFile)

    var media: Media {
        switch self {
        case let .media(media):
            return media
        case let .uploadedMedia(uploadedMedia):
            return uploadedMedia.media
        case let .audioFile(audioFile):
            return audioFile.media
        }
    }
}
