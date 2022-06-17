import Foundation

struct LocalMediaMessageItemContent<M: Media> {
    let media: M
    var uploadUuid: UUID?
}
