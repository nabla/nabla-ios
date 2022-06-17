import Foundation

struct MediaComposerItemViewModel {
    enum MediaType {
        case image
        case video
        case pdf
    }

    let url: URL
    let type: MediaType
}
