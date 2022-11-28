import Foundation

public struct PaginatedList<T> {
    public let elements: [T]
    public let loadMore: (() async throws -> Void)?
    
    public var hasMore: Bool {
        loadMore != nil
    }
    
    public init(
        elements: [T],
        loadMore: (() async throws -> Void)?
    ) {
        self.elements = elements
        self.loadMore = loadMore
    }
    
    public static var empty: Self {
        .init(elements: [], loadMore: nil)
    }
}
