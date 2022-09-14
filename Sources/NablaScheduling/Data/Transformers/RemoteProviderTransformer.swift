import Foundation

enum RemoteProviderTransformer {
    static func transform(_ remote: RemoteProvider) -> Provider {
        Provider(
            id: remote.id,
            prefix: remote.prefix,
            firstName: remote.firstName,
            lastName: remote.lastName,
            title: remote.title,
            avatarUrl: URL(string: remote.avatarUrl?.url)
        )
    }
}
