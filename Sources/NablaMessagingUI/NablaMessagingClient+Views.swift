import NablaMessagingCore

public extension NablaMessagingClient {
    @MainActor var views: NablaMessagingViewFactory {
        NablaMessagingViewFactory(client: self)
    }
}
