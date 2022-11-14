import SnapshotTesting
import XCTest

/// Exaplanation around `perceptualPrecision` can be found here:
/// https://github.com/pointfreeco/swift-snapshot-testing/pull/628
///
/// `precision: 0.995` is the recommended value for iOS version changes
/// `perceptualPrecision: 0.98` is the recommended value for M1 vs Intel rendring changes.

public extension Dictionary where Key == String, Value == Snapshotting<UIView, UIImage> {
    static func lightAndDarkImages(
        wait time: TimeInterval = 0,
        size: CGSize? = nil
    ) -> Dictionary {
        [
            "light": Snapshotting.wait(
                for: time,
                on: .image(
                    precision: 0.995,
                    perceptualPrecision: 0.95,
                    size: size,
                    traits: UITraitCollection(userInterfaceStyle: .light)
                )
            ),
            "dark": Snapshotting.wait(
                for: time,
                on: .image(
                    precision: 0.995,
                    perceptualPrecision: 0.95,
                    size: size,
                    traits: UITraitCollection(userInterfaceStyle: .dark)
                )
            ),
        ]
    }
}

public extension Dictionary where Key == String, Value == Snapshotting<UIViewController, UIImage> {
    static func lightAndDarkImages(
        wait time: TimeInterval = 0,
        size: CGSize? = nil
    ) -> Dictionary {
        [
            "light": Snapshotting.wait(
                for: time,
                on: .image(
                    precision: 0.995,
                    perceptualPrecision: 0.98,
                    size: size,
                    traits: UITraitCollection(userInterfaceStyle: .light)
                )
            ),
            "dark": Snapshotting.wait(
                for: time,
                on: .image(
                    precision: 0.995,
                    perceptualPrecision: 0.98,
                    size: size,
                    traits: UITraitCollection(userInterfaceStyle: .dark)
                )
            ),
        ]
    }
}
