import Foundation

enum RemoteCategoryTransformer {
    static func transform(_ remoteCategory: RemoteCategory) -> Category {
        Category(
            id: remoteCategory.id,
            name: remoteCategory.name
        )
    }
}
