import Foundation

public struct Name {
    public let value: String

    public init(value: String) {
        self.value = value
    }

    public static func create(by filename: String) -> ValidationResult<Name, FailureReason> {
        .valid(Name(value: filename))
    }

    public enum FailureReason {}
}
