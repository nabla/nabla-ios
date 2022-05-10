import NablaMessagingCore
import NablaMessagingUI
import UIKit

class ViewController: DemoViewController {
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId = UUID() // Replace with your own `userId`
        NablaClient.shared.authenticate(userId: userId, provider: FakeAuthenticator.shared)
        let view = NablaViewFactory.createConversationListView(delegate: self)
        setContentView(view)
    }
    
    // MARK: Handlers
    
    override func createConversationButtonHandler() {
        createConversationAction = NablaMessagingClient.shared.createConversation { result in
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
