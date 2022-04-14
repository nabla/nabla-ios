import Foundation

public struct Media: Equatable {
    public let type: MediaType
    public let fileName: String
    public let fileUrl: URL
    public let mimeType: MimeType
}
