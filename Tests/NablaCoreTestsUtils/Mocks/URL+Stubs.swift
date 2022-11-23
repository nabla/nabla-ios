import Foundation
import NablaCore

public extension URL {
    static var stubImage: URL {
        // swiftlint:disable:next force_unwrapping
        NablaCoreTestsUtilsPackage.resourcesBundle.url(forResource: "stubImage", withExtension: "png")!
    }
}

public extension Data {
    static var stubImage: Data {
        // swiftlint:disable:next force_try
        try! Data(contentsOf: .stubImage)
    }
}
