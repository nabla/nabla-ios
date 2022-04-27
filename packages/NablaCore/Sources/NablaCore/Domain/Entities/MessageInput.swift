import Foundation

public enum MessageInput {
    case text(content: String)
    case image(content: Media)
    case document(content: Media)
}
