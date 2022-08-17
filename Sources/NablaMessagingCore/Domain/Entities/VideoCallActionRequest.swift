import Foundation

public struct VideoCallActionRequest: ConversationActionRequest {
    public let id: UUID
    public let date: Date
    public let sender: ConversationMessageSender
    public let status: Status
    
    public enum Status {
        case closed
        case open(Room)
    }
    
    public struct Room {
        public let url: String
        public let token: String
    }
}
