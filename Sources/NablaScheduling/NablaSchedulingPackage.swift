import Foundation
import UIKit

final class NablaSchedulingPackage {
    static let resourcesBundle: Bundle = {
        if let url = bundle.url(forResource: "NablaSchedulingResources", withExtension: "bundle"),
           let bundle = Bundle(url: url) {
            return bundle
        } else {
            return bundle
        }
    }()
    
    private static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: NablaSchedulingPackage.self)
        #endif
    }()
}
