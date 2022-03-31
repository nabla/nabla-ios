import Foundation

protocol RestConversationMapper {
    func map(_ conversation: RestConversation) -> Conversation
}
