import Foundation

public protocol BoundaryGenerator {
    static func generate() -> String
}

public class RandomBoundaryGenerator: BoundaryGenerator {
    public static func generate() -> String {
        // swiftlint:disable:next legacy_random
        String(format: "%08x%08x", arc4random(), arc4random())
    }
}
