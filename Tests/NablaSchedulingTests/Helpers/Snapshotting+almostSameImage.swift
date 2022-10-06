import SnapshotTesting
import XCTest

// Two tests are failing when ran on the non M1 CI mac
// The differences are invisible to the human eye
extension Snapshotting where Value == UIView, Format == UIImage {
    static var almostSameImage: Snapshotting {
        image(precision: 0.99)
    }
}

extension Snapshotting where Value == UIViewController, Format == UIImage {
    static var almostSameImage: Snapshotting {
        image(precision: 0.99)
    }
}
