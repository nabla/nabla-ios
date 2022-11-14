import Foundation

public extension URL {
    static var stubImage: Self {
        .init(string: .urlStubImage)! // swiftlint:disable:this force_unwrapping
    }
    
    static var stubInvalidImage: Self {
        .init(string: .urlStubInvalidImage)! // swiftlint:disable:this force_unwrapping
    }

    static var stubVideo: Self {
        .init(string: .urlStubVideo)! // swiftlint:disable:this force_unwrapping
    }
    
    static var stubInvalidVideo: Self {
        .init(string: .urlStubInvalidVideo)! // swiftlint:disable:this force_unwrapping
    }
}
