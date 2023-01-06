import Foundation

public struct PaginatedList<Element> {
    public let elements: [Element]
    public let loadMore: (() async throws -> Void)?
    
    public var hasMore: Bool {
        loadMore != nil
    }
    
    public init(
        elements: [Element],
        loadMore: (() async throws -> Void)?
    ) {
        self.elements = elements
        self.loadMore = loadMore
    }
    
    public static var empty: Self {
        .init(elements: [], loadMore: nil)
    }
}

public extension PaginatedList {
    func map<T>(_ transform: (Element) -> T) -> PaginatedList<T> {
        .init(
            elements: elements.map(transform),
            loadMore: loadMore
        )
    }
}
