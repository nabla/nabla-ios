import Foundation
@testable import NablaMessagingCore

extension LocalConversation {
    static func mock(
        title: String? = "Title"
    ) -> LocalConversation {
        .init(
            id: .init(),
            creationDate: Date(),
            title: title,
            providerIds: []
        )
    }
}
