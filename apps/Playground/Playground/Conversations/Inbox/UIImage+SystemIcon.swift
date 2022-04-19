import UIKit

enum SystemIcon: String {
    case squareAndPencil = "square.and.pencil"
}

extension UIImage {
    static var squareAndPencil: UIImage { UIImage(systemIcon: .squareAndPencil) }
    
    convenience init(systemIcon: SystemIcon) {
        // swiftlint:disable:next force_unwrapping
        self.init(systemName: systemIcon.rawValue)!
    }
}
