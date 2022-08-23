import UIKit

public extension NablaExtension where Base: UIDevice {
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
}
