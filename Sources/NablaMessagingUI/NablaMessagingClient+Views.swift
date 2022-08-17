import NablaMessagingCore

public extension NablaMessagingClient {
    var views: NablaMessagingViewFactory {
        NablaMessagingViewFactory(client: self)
    }
}
