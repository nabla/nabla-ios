import Foundation

public struct UniversalLink {
    public let displayName: String
    public let open: () -> Void
}

public protocol UniversalLinkGenerator {
    func makeUniversalLinks(forAdress address: Address) -> [UniversalLink]
}
