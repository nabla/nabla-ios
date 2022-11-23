import Foundation
import UIKit

final class NablaCoreTestsUtilsPackage {
    static let resourcesBundle: Bundle = {
        if let url = bundle.url(forResource: "NablaCoreTestsUtilsResources", withExtension: "bundle"),
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
            return Bundle(for: NablaCoreTestsUtilsPackage.self)
        #endif
    }()
}
