import NablaCore
import NablaMessagingCore
import NablaMessagingUI
import UIKit

class ViewController: DemoViewController {
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let userId = "dummy_user_id" // In a real scenario, you need to replace it with your own stable user id.
            try NablaClient.shared.setCurrentUser(userId: userId)
            let view = NablaClient.shared.messaging.views.createConversationListView(delegate: self)
            setContentView(view)
        } catch {
            print("Unable to set the current user, reason: \(error)")
        }
    }
    
    // MARK: Handlers
    
    override func createConversationButtonHandler() {
        let conversation = NablaMessagingClient.shared.startConversation()
        let destination = NablaClient.shared.messaging.views.createConversationViewController(conversation)
        navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Private
    
    private var createConversationAction: Any?
}

extension ViewController: ConversationListDelegate {
    func conversationList(didSelect conversation: Conversation) {
        let destination = NablaClient.shared.messaging.views.createConversationViewController(conversation)
        navigationController?.pushViewController(destination, animated: true)
    }
}
