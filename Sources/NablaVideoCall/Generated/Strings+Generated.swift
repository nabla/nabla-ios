// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Retry
  internal static let failedToConnectErrorAction = L10n.tr("Localizable", "failed_to_connect_error_action")
  /// Failed to connect to your call. Please try again later.
  internal static let failedToConnectErrorMessage = L10n.tr("Localizable", "failed_to_connect_error_message")
  /// Go to Settings
  internal static let permissionsDeniedErrorAction = L10n.tr("Localizable", "permissions_denied_error_action")
  /// Permissions to access microphone and camera are needed for remote consultations.
  internal static let permissionsDeniedErrorMessage = L10n.tr("Localizable", "permissions_denied_error_message")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NablaVideoCallPackage.resourcesBundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
