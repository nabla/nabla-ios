import Foundation
import class Foundation.Bundle

private class BundleFinder {}

enum NablaMessagingCoreIntegrationTestsPackage {
    /// Returns the resource bundle associated with the current Swift module.
    static var bunble: Bundle = {
        let bundleName = "nabla-ios_NablaMessagingCoreIntegrationTests"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            
            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,
            
            // For command-line tools.
            Bundle.main.bundleURL,
            
            Bundle.allBundles.first(where: { $0.bundlePath.hasSuffix("NablaMessagingCoreIntegrationTests.xctest") })?.resourceURL,
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named nabla-ios_NablaMessagingCore")
    }()
}
