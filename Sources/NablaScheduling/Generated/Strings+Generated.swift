// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Schedule an appointment
  internal static let appointmentsScreenActionButtonLabel = L10n.tr("Localizable", "appointments_screen_action_button_label")
  /// Failed to cancel the appointment. Please try again.
  internal static let appointmentsScreenCancelAppointmentErrorMessage = L10n.tr("Localizable", "appointments_screen_cancel_appointment_error_message")
  /// Something went wrong
  internal static let appointmentsScreenCancelAppointmentErrorTitle = L10n.tr("Localizable", "appointments_screen_cancel_appointment_error_title")
  /// Keep appointment
  internal static let appointmentsScreenCancelAppointmentModalCloseButton = L10n.tr("Localizable", "appointments_screen_cancel_appointment_modal_close_button")
  /// Confirm cancellation
  internal static let appointmentsScreenCancelAppointmentModalConfirmButton = L10n.tr("Localizable", "appointments_screen_cancel_appointment_modal_confirm_button")
  /// The appointment will be canceled.
  internal static let appointmentsScreenCancelAppointmentModalMessage = L10n.tr("Localizable", "appointments_screen_cancel_appointment_modal_message")
  /// Cancel appointment
  internal static let appointmentsScreenCancelAppointmentModalTitle = L10n.tr("Localizable", "appointments_screen_cancel_appointment_modal_title")
  /// Join the call
  internal static let appointmentsScreenCellJoinButtonLabel = L10n.tr("Localizable", "appointments_screen_cell_join_button_label")
  /// Return to call
  internal static let appointmentsScreenCellJoinInprogressButtonLabel = L10n.tr("Localizable", "appointments_screen_cell_join_inprogress_button_label")
  /// No past appointments
  internal static let appointmentsScreenFinalizedEmptyLabel = L10n.tr("Localizable", "appointments_screen_finalized_empty_label")
  /// Failed to load the appointments. Please try again.
  internal static let appointmentsScreenLoadListErrorMessage = L10n.tr("Localizable", "appointments_screen_load_list_error_message")
  /// Something went wrong
  internal static let appointmentsScreenLoadListErrorTitle = L10n.tr("Localizable", "appointments_screen_load_list_error_title")
  /// Cancel appointment
  internal static let appointmentsScreenSecondaryActionsSheetCancelAppointmentButton = L10n.tr("Localizable", "appointments_screen_secondary_actions_sheet_cancel_appointment_button")
  /// Cancel
  internal static let appointmentsScreenSecondaryActionsSheetCloseButton = L10n.tr("Localizable", "appointments_screen_secondary_actions_sheet_close_button")
  /// Past
  internal static let appointmentsScreenSelectorFinalizedLabel = L10n.tr("Localizable", "appointments_screen_selector_finalized_label")
  /// Scheduled
  internal static let appointmentsScreenSelectorUpcomingLabel = L10n.tr("Localizable", "appointments_screen_selector_upcoming_label")
  /// Appointments
  internal static let appointmentsScreenTitle = L10n.tr("Localizable", "appointments_screen_title")
  /// No appointments scheduled
  internal static let appointmentsScreenUpcomingEmptyLabel = L10n.tr("Localizable", "appointments_screen_upcoming_empty_label")
  /// No categories available
  internal static let categoryPickerScreenEmptyLabel = L10n.tr("Localizable", "category_picker_screen_empty_label")
  /// Failed to display the categories. Please try again.
  internal static let categoryPickerScreenErrorMessage = L10n.tr("Localizable", "category_picker_screen_error_message")
  /// Something went wrong
  internal static let categoryPickerScreenErrorTitle = L10n.tr("Localizable", "category_picker_screen_error_title")
  /// Select a category
  internal static let categoryPickerScreenTitle = L10n.tr("Localizable", "category_picker_screen_title")
  /// Confirm the appointment
  internal static let confirmationScreenActionButtonLabel = L10n.tr("Localizable", "confirmation_screen_action_button_label")
  /// Consultation planned on %@
  internal static func confirmationScreenCaptionFormat(_ p1: Any) -> String {
    return L10n.tr("Localizable", "confirmation_screen_caption_format", String(describing: p1))
  }
  /// Consultation planned today at %@
  internal static func confirmationScreenCaptionFormatToday(_ p1: Any) -> String {
    return L10n.tr("Localizable", "confirmation_screen_caption_format_today", String(describing: p1))
  }
  /// I consent to do a video consultation.
  internal static let confirmationScreenConsultationDisclaimer = L10n.tr("Localizable", "confirmation_screen_consultation_disclaimer")
  /// I consent to the data processing policy.
  internal static let confirmationScreenDataDisclaimer = L10n.tr("Localizable", "confirmation_screen_data_disclaimer")
  /// Failed to schedule appointment. Please try again.
  internal static let confirmationScreenErrorMessage = L10n.tr("Localizable", "confirmation_screen_error_message")
  /// Something went wrong
  internal static let confirmationScreenErrorTitle = L10n.tr("Localizable", "confirmation_screen_error_title")
  /// Confirm your appointment
  internal static let confirmationScreenTitle = L10n.tr("Localizable", "confirmation_screen_title")
  /// No availabilities
  internal static let timeSlotsPickerScreenEmptyLabel = L10n.tr("Localizable", "time_slots_picker_screen_empty_label")
  /// Failed to display the availabilities. Please try again.
  internal static let timeSlotsPickerScreenErrorMessage = L10n.tr("Localizable", "time_slots_picker_screen_error_message")
  /// Something went wrong
  internal static let timeSlotsPickerScreenErrorTitle = L10n.tr("Localizable", "time_slots_picker_screen_error_title")
  /// %d available slots
  internal static func timeSlotsPickerScreenGroupSubtitleFormat(_ p1: Int) -> String {
    return L10n.tr("Localizable", "time_slots_picker_screen_group_subtitle_format", p1)
  }
  /// Confirm
  internal static let timeSlotsScreenActionButtonLabel = L10n.tr("Localizable", "time_slots_screen_action_button_label")
  /// Select a date
  internal static let timeSlotsScreenTitle = L10n.tr("Localizable", "time_slots_screen_title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NablaSchedulingPackage.resourcesBundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
