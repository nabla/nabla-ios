// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Assets {
  internal enum Assets {
  }
  internal enum Colors {
    internal static let black = ColorAsset(name: "black")
    internal static let blue100 = ColorAsset(name: "blue100")
    internal static let blue200 = ColorAsset(name: "blue200")
    internal static let blue300 = ColorAsset(name: "blue300")
    internal static let blue400 = ColorAsset(name: "blue400")
    internal static let blue500 = ColorAsset(name: "blue500")
    internal static let blue600 = ColorAsset(name: "blue600")
    internal static let grey100 = ColorAsset(name: "grey100")
    internal static let grey200 = ColorAsset(name: "grey200")
    internal static let grey300 = ColorAsset(name: "grey300")
    internal static let grey400 = ColorAsset(name: "grey400")
    internal static let grey500 = ColorAsset(name: "grey500")
    internal static let grey600 = ColorAsset(name: "grey600")
    internal static let grey700 = ColorAsset(name: "grey700")
    internal static let grey800 = ColorAsset(name: "grey800")
    internal static let red100 = ColorAsset(name: "red100")
    internal static let white = ColorAsset(name: "white")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = NablaCorePackage.resourcesBundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = NablaCorePackage.resourcesBundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}
