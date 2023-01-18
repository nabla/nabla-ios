import Foundation

public class GoogleMapsUniversalLinkGenerator: MapAppUniversalLinkGenerator {
    // MARK: - Public
    
    public let allowOpeningInWebBrower: Bool
    
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
        allowOpeningInWebBrower: Bool
    ) {
        self.init(
            allowOpeningInWebBrower: allowOpeningInWebBrower,
            formatter: FoundationAddressFormatter()
        )
    }
    
    // MARK: - Internal
    
    init(
        allowOpeningInWebBrower: Bool,
        formatter: AddressFormatter
    ) {
        self.allowOpeningInWebBrower = allowOpeningInWebBrower
        self.formatter = formatter
    }
    
    // MARK: - Private
    
    private let formatter: AddressFormatter
}
