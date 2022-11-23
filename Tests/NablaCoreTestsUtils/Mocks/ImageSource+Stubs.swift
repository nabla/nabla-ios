import Foundation
import NablaCore

public extension ImageSource {
    static var stubLocalImage: ImageSource {
        .data(.stubImage)
    }
}
