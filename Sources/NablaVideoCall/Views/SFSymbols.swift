import Foundation
import UIKit

enum SFSymbols: String {
    case chevronDown = "chevron.down"
    case microphone = "mic"
    case microphoneSlash = "mic.slash"
    case video
    case videoSlash = "video.slash"
    case rotateCamera = "camera.rotate"
    case phoneDownFill = "phone.down.fill"
    
    var image: UIImage {
        // swiftlint:disable:next force_unwrapping
        UIImage(systemName: rawValue)!
    }
}
