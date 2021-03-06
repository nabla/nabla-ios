import Foundation

public extension URL {
    static var stubImage: Self {
        .init(string: .urlStubImage)! // swiftlint:disable:this force_unwrapping
    }

    static var stubVideo: Self {
        .init(string: .urlStubVideo)! // swiftlint:disable:this force_unwrapping
    }
}
