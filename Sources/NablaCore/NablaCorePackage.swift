import Foundation
import UIKit

final class NablaCorePackage {
    static let resourcesBundle: Bundle = {
        if let url = bundle.url(forResource: "NablaCoreResources", withExtension: "bundle"),
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
            return Bundle(for: NablaCorePackage.self)
        #endif
    }()
}
