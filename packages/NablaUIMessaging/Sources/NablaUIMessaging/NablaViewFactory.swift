import Foundation
import NablaCore

public struct NablaViewFactory {
    public func createConversationListView(delegate: ConversationListViewDelegate) -> ConversationListView {
        let view = ConversationListView(frame: .zero)
        view.delegate = delegate
        let presenter = ConversationListPresenterImpl(
            viewContract: view,
            client: NablaClient.shared
        )
        view.presenter = presenter
        return view
    }
}
