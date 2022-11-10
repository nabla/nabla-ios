import SnapshotTesting
import XCTest

public extension Dictionary where Key == String, Value == Snapshotting<UIView, UIImage> {
    static func lightAndDarkImages(
        wait time: TimeInterval = 0,
        size: CGSize? = nil,
        tolerant: Bool = false
    ) -> Dictionary {
        [
            "light": Snapshotting.wait(
                for: time,
                on: .image(
                    precision: tolerant ? 1 : 0.99,
                    size: size,
                    traits: UITraitCollection(userInterfaceStyle: .light)
                )
            ),
            "dark": Snapshotting.wait(
                for: time,
                on: .image(
                    precision: tolerant ? 1 : 0.99,
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
        size: CGSize? = nil,
        tolerant: Bool = false
    ) -> Dictionary {
        [
            "light": Snapshotting.wait(
                for: time,
                on: .image(
                    precision: tolerant ? 1 : 0.99,
                    size: size,
                    traits: UITraitCollection(userInterfaceStyle: .light)
                )
            ),
            "dark": Snapshotting.wait(
                for: time,
                on: .image(
                    precision: tolerant ? 1 : 0.99,
                    size: size,
                    traits: UITraitCollection(userInterfaceStyle: .dark)
                )
            ),
        ]
    }
}
