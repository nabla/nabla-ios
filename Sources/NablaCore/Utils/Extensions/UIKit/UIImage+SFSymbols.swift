import UIKit

public extension NablaExtension where Base: UIImage {
    enum SFSymbol: String {
        case chevronDown = "chevron.down"
        case chevronUp = "chevron.up"
        case chevronRight = "chevron.right"
        case microphone = "mic"
        case microphoneSlash = "mic.slash"
        case video
        case videoSlash = "video.slash"
        case rotateCamera = "camera.rotate"
        case phoneDownFill = "phone.down.fill"
        case ellipsis
        case playFill = "play.fill"
    }
    
    static func symbol(_ symbol: SFSymbol) -> UIImage {
        // swiftlint:disable:next force_unwrapping
        UIImage(systemName: symbol.rawValue)!
    }
}
