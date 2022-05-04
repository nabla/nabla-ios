import Foundation

struct MediaComposerItemViewModel {
    enum MediaType {
        case image
        case pdf
    }

    let url: URL
    let type: MediaType
}
