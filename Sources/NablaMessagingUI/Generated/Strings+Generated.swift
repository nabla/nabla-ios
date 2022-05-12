// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Copy
  internal static let conversationActionCopy = L10n.tr("Localizable", "conversation_action_copy")
  /// Delete
  internal static let conversationActionDelete = L10n.tr("Localizable", "conversation_action_delete")
  /// Camera
  internal static let conversationAddMediaCamera = L10n.tr("Localizable", "conversation_add_media_camera")
  /// Cancel
  internal static let conversationAddMediaCancel = L10n.tr("Localizable", "conversation_add_media_cancel")
  /// Document
  internal static let conversationAddMediaDocument = L10n.tr("Localizable", "conversation_add_media_document")
  /// Photo Library
  internal static let conversationAddMediaLibrary = L10n.tr("Localizable", "conversation_add_media_library")
  /// Type your message
  internal static let conversationComposerPlaceholder = L10n.tr("Localizable", "conversation_composer_placeholder")
  /// %@ at %@
  internal static func conversationDateSeparatorDateTime(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "conversation_date_separator_date_time", String(describing: p1), String(describing: p2))
  }
  /// Today
  internal static let conversationDateSeparatorDateToday = L10n.tr("Localizable", "conversation_date_separator_date_today")
  /// Yesterday
  internal static let conversationDateSeparatorDateYesterday = L10n.tr("Localizable", "conversation_date_separator_date_yesterday")
  /// OK
  internal static let conversationDeleteErrorAlertAction = L10n.tr("Localizable", "conversation_delete_error_alert_action")
  /// An error occurred while deleting the message, please try again.
  internal static let conversationDeleteErrorMessage = L10n.tr("Localizable", "conversation_delete_error_message")
  /// Error
  internal static let conversationDeleteErrorTitle = L10n.tr("Localizable", "conversation_delete_error_title")
  /// Deleted message
  internal static let conversationDeletedMessage = L10n.tr("Localizable", "conversation_deleted_message")
  /// Deleted
  internal static let conversationDeletedSender = L10n.tr("Localizable", "conversation_deleted_sender")
  /// Retry
  internal static let conversationListButtonRetry = L10n.tr("Localizable", "conversation_list_button_retry")
  /// New conversation
  internal static let conversationListEmptyPreview = L10n.tr("Localizable", "conversation_list_empty_preview")
  /// Yesterday
  internal static let conversationListLastMessageYesterday = L10n.tr("Localizable", "conversation_list_last_message_yesterday")
  /// An error occurred while loading the conversations, please try again.
  internal static let conversationListLoadErrorLabel = L10n.tr("Localizable", "conversation_list_load_error_label")
  /// An error occurred while loading the messages, please try again.
  internal static let conversationLoadErrorLabel = L10n.tr("Localizable", "conversation_load_error_label")
  /// OK
  internal static let conversationLoadMoreErrorAlertAction = L10n.tr("Localizable", "conversation_load_more_error_alert_action")
  /// An error occurred while loading the messages.
  internal static let conversationLoadMoreErrorMessage = L10n.tr("Localizable", "conversation_load_more_error_message")
  /// Error
  internal static let conversationLoadMoreErrorTitle = L10n.tr("Localizable", "conversation_load_more_error_title")
  /// Failed to send, tap to try again…
  internal static let conversationStatusFailed = L10n.tr("Localizable", "conversation_status_failed")
  /// Sending…
  internal static let conversationStatusSending = L10n.tr("Localizable", "conversation_status_sending")
  /// System
  internal static let conversationSystemSender = L10n.tr("Localizable", "conversation_system_sender")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
