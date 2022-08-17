import Foundation

extension String: NablaExtendable {}

public extension NablaExtension where Base == String {
    var nilIfEmpty: String? {
        base.isEmpty ? nil : base
    }
}
