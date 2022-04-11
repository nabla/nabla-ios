import Foundation

protocol RestConversationTransformer {
    func transform(_ conversation: RestConversation) -> Conversation
}
