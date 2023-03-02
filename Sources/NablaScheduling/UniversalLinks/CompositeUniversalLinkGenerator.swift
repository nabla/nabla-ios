import Foundation

final class CompositeUniversalLinkGenerator: UniversalLinkGenerator {
    // MARK: - Internal
    
    var generators: [UniversalLinkGenerator]
    
    func makeUniversalLinks(forAddress address: Address) -> [UniversalLink] {
        generators.flatMap { $0.makeUniversalLinks(forAddress: address) }
    }
    
    // MARK: Init
    
    init(
        generators: [UniversalLinkGenerator]
    ) {
        self.generators = generators
    }
    
    // MARK: - Private
}
