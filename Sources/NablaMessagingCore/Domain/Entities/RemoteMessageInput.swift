import Foundation

enum RemoteMessageInput {
    case text(String)
    case image(UploadedMedia<ImageFile>)
    case video(UploadedMedia<VideoFile>)
    case document(UploadedMedia<DocumentFile>)
    case audio(UploadedMedia<AudioFile>)
}
