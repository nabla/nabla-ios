import Foundation

public struct AvatarViewModel: Hashable {
    public let url: String?
    public let text: String?
    
    public init(
        url: String?,
        text: String?
    ) {
        self.url = url
        self.text = text
    }
}
