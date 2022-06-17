import Foundation

struct UploadedMedia<M: Media> {
    let fileUploadUUID: UUID
    let media: M
}
