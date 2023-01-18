import Foundation

public class AppleMapsUniversalLinkGenerator: MapAppUniversalLinkGenerator {
    // MARK: - Public
    
    public var allowOpeningInWebBrower: Bool {
        // iOS does not let us know if Apple Maps is installed.
        // Therefore we can't detect when it will use the browser instead
        // and should always support it.
        true
    }
    
    public var displayName: String {
        L10n.universalLinkAppleMaps
    }
    
    public var applicationUrlScheme: String? {
        "maps"
    }
    
    public func makeQueryUrl(address: Address) -> URL? {
        guard let query = formatter.format(address).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return URL(string: "https://maps.apple.com/?q=\(query)")
    }
    
    // MARK: Init
    
    public convenience init() {
        self.init(formatter: FoundationAddressFormatter())
    }
    
    // MARK: - Internal
    
    init(
        formatter: AddressFormatter
    ) {
        self.formatter = formatter
    }
    
    // MARK: - Private
    
    private let formatter: AddressFormatter
}
