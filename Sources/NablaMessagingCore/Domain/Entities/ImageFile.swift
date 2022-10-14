import Foundation
import NablaCore

public struct ImageFile: Media, Equatable, Hashable {
    public let fileName: String
    public let content: MediaContent
    public let size: MediaSize?
    public let imageMimeType: MimeType.Image

    public var mimeType: MimeType {
        .image(imageMimeType)
    }

    public init(fileName: String, content: MediaContent, size: MediaSize?, mimeType: MimeType.Image) {
        self.fileName = fileName
        self.content = content
        self.size = size
        imageMimeType = mimeType
    }
}
