import Foundation
import NablaCore
import UIKit

public enum NablaViewFactory {
    public static func createConversationListView(delegate: ConversationListDelegate) -> ConversationListView {
        let view = ConversationListView(frame: .zero)
        let presenter = ConversationListPresenterImpl(
            viewContract: view,
            delegate: delegate,
            client: NablaClient.shared
        )
        view.presenter = presenter
        return view
    }

    public static func createConversationViewController() -> UIViewController {
        let viewController = ConversationViewController(
            providers: [
                DateSeparatorCellProvider(),
                EventCellProvider(),
                TextMessageCellProvider(),
            ]
        )
        viewController.presenter = ConversationPresenterImpl(
            view: viewController
        )
        return viewController
    }
}
