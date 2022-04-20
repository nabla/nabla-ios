import Foundation

public extension DateFormatter {
    enum LocaleType {
        /// Locale used when parsing dates from the server.
        case server

        /// Locale synchronized to the current device settings.
        ///
        /// Warning: using this locale type can lead to unexpected errors when parsing, e.g. on devices with AM/PM time.
        /// See https://nabla.workplace.com/groups/180422653589458/permalink/206582034306853/.
        case device
    }

    convenience init(locale: LocaleType) {
        self.init()

        switch locale {
        case .server:
            self.locale = Locale(identifier: "en_US_POSIX")
        case .device:
            self.locale = .current
        }
    }
}
