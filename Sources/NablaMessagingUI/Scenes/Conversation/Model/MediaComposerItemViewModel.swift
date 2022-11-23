import Foundation
import NablaCore

struct MediaComposerItemViewModel {
    enum MediaType {
        case image(source: ImageSource)
        case video(source: MediaSource)
        case pdf
    }

    let type: MediaType
}
