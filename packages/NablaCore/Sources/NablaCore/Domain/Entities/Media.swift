import Foundation

public struct Media: Equatable, Hashable {
    public let type: MediaType
    public let fileName: String
    public let fileUrl: URL
    public let mimeType: MimeType

    public init(type: MediaType, fileName: String, fileUrl: URL, mimeType: MimeType) {
        self.type = type
        self.fileName = fileName
        self.fileUrl = fileUrl
        self.mimeType = mimeType
    }
}
