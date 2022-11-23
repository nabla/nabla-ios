import Foundation

public extension URL {
    static var stubVideo: Self {
        .init(string: .urlStubVideo)! // swiftlint:disable:this force_unwrapping
    }
    
    static var stubInvalidVideo: Self {
        .init(string: .urlStubInvalidVideo)! // swiftlint:disable:this force_unwrapping
    }
}
