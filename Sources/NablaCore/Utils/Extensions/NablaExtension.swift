import Foundation
import UIKit

public struct NablaExtension<Base> {
    /// Base object to extend.
    let base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    init(_ base: Base) {
        self.base = base
    }
}

/// A type that has nabla extensions.
public protocol NablaExtendable {
    /// Extended type
    associatedtype ExtendedBase

    /// Nabla extensions.
    static var nabla: NablaExtension<ExtendedBase>.Type { get set }

    /// Nabla extensions.
    var nabla: NablaExtension<ExtendedBase> { get set }
}

public extension NablaExtendable {
    /// Nabla extensions.
    static var nabla: NablaExtension<Self>.Type {
        get { NablaExtension<Self>.self }
        // this enables using NablaExtension to "mutate" base type
        // swiftlint:disable:next unused_setter_value
        set {}
    }

    /// Nabla extensions.
    var nabla: NablaExtension<Self> {
        get { NablaExtension(self) }
        // this enables using NablaExtension to "mutate" base object
        // swiftlint:disable:next unused_setter_value
        set {}
    }
}

extension NSObject: NablaExtendable {}
extension Int: NablaExtendable {}
extension Double: NablaExtendable {}
extension CGFloat: NablaExtendable {}
