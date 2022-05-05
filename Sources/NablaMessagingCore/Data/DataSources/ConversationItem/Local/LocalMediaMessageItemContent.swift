import Foundation

enum LocalMediaMessageItemContent {
    case media(Media)
    case uploadedMedia(UploadedMedia)

    var media: Media {
        switch self {
        case let .media(media):
            return media
        case let .uploadedMedia(uploadedMedia):
            return uploadedMedia.media
        }
    }
}
