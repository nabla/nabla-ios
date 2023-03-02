import Foundation

open class NablaError: Error {
    public init() {}
    
    open func serialize() -> [String: Any] {
        ["type": String(describing: self)]
    }
}
