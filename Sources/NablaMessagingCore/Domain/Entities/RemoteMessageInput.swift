import Foundation

enum RemoteMessageInput {
    case text(String)
    case image(UploadedMedia)
    case video(UploadedMedia)
    case document(UploadedMedia)
    case audio(UploadedMedia)
}
