import NablaMessagingCore
import NablaMessagingUI
import UIKit

class ViewController: DemoViewController {
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NablaClient.shared.authenticate(provider: FakeAuthenticator.shared) { result in
            switch result {
            case let .failure(error):
                print(error)
            case .success:
                let view = NablaViewFactory.createConversationListView(delegate: self)
                self.setContentView(view)
            }
        }
    }
    
    // MARK: Handlers
    
    override func createConversationButtonHandler() {
        createConversationAction = NablaClient.shared.createConversation { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(conversation):
                let destination = NablaViewFactory.createConversationViewController(conversation)
                self.navigationController?.pushViewController(destination, animated: true)
            }
        }
    }
    
    // MARK: - Private
    
    private var createConversationAction: Any?
}

extension ViewController: ConversationListDelegate {
    func conversationList(didSelect conversation: Conversation) {
        let destination = NablaViewFactory.createConversationViewController(conversation)
        navigationController?.pushViewController(destination, animated: true)
    }
}
