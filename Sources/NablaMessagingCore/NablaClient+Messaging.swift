import NablaCore

public extension NablaClient {
    var messaging: NablaMessagingClient {
        guard let client = container.messagingClient as? NablaMessagingClient else {
            fatalError("`NablaMessagingClient` not initilized. You must provide a `NablaMessagingModule` to `NablaClient.initialize()`.")
        }
        return client
    }
}
