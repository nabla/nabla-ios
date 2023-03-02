import Foundation

public class GoogleMapsUniversalLinkGenerator: MapAppUniversalLinkGenerator {
    // MARK: - Public
    
    public let allowOpeningInWebBrowser: Bool
    
    public var displayName: String {
        L10n.universalLinkGoogleMaps
    }
    
    public var applicationUrlScheme: String? {
        "comgooglemaps"
    }
    
    public func makeQueryUrl(address: Address) -> URL? {
        guard let query = formatter.format(address).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return URL(string: "https://www.google.com/maps/search/?api=1&query=\(query)")
    }
    
    // MARK: Init
    
    public convenience init(
        allowOpeningInWebBrowser: Bool
    ) {
        self.init(
            allowOpeningInWebBrowser: allowOpeningInWebBrowser,
            formatter: FoundationAddressFormatter()
        )
    }
    
    // MARK: - Internal
    
    init(
        allowOpeningInWebBrowser: Bool,
        formatter: AddressFormatter
    ) {
        self.allowOpeningInWebBrowser = allowOpeningInWebBrowser
        self.formatter = formatter
    }
    
    // MARK: - Private
    
    private let formatter: AddressFormatter
}
