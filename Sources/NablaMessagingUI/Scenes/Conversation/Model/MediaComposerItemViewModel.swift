import Foundation
import NablaCore

struct MediaComposerItemViewModel {
    enum MediaType {
        case image
        case video
        case pdf
    }

    let mediaSource: MediaSource
    let type: MediaType
}
