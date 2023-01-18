import Foundation

final class CompositeUniversalLinkGenerator: UniversalLinkGenerator {
    // MARK: - Internal
    
    var generators: [UniversalLinkGenerator]
    
    func makeUniversalLinks(forAdress address: Address) -> [UniversalLink] {
        generators.flatMap { $0.makeUniversalLinks(forAdress: address) }
    }
    
    // MARK: Init
    
    init(
        generators: [UniversalLinkGenerator]
    ) {
        self.generators = generators
    }
    
    // MARK: - Private
}
