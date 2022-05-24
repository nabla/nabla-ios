import Foundation

public extension URL {
    static var stub: Self {
        .init(string: .urlStub)! // swiftlint:disable:this force_unwrapping
    }
}
