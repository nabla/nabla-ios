import Foundation
import UIKit

/// A type of ``UniversalLinkGenerator`` designed to open addresses in an app installed on the user's device.
public protocol MapAppUniversalLinkGenerator: UniversalLinkGenerator {
    /// The name used when listing the apps eligible to open the address.
    var displayName: String { get }
    /// The URL scheme of the app to open. It must be registered under `LSApplicationQueriesSchemes` in your info.plist file.
    /// If you don't want to open an app and only care about the web browser, you can return nil.
    var applicationUrlScheme: String? { get }
    /// Whether the SDK should open the web browser instead of the app when not installed.
    var allowOpeningInWebBrowser: Bool { get }
    /// The universal link or url scheme link to open for the `Address`.
    /// Make sure to provide a universal link if you want the browser support when the application is not installed.
    /// Each application uses a different format for the query. Refer to their documentation to implement this method.
    func makeQueryUrl(address: Address) -> URL?
}

public extension MapAppUniversalLinkGenerator {
    func makeUniversalLinks(forAddress address: Address) -> [UniversalLink] {
        guard
            canOpenApplicationOrWebBrowser,
            let url = makeQueryUrl(address: address)
        else { return [] }
        let link = UniversalLink(displayName: displayName) {
            UIApplication.shared.open(url)
        }
        return [link]
    }
    
    private var canOpenApplicationOrWebBrowser: Bool {
        if allowOpeningInWebBrowser { return true }
        guard
            let rawUrlScheme = applicationUrlScheme,
            let urlScheme = URL(string: "\(rawUrlScheme)://") ?? URL(string: rawUrlScheme)
        else { return false }
        return UIApplication.shared.canOpenURL(urlScheme)
    }
}
