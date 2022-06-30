import Foundation
import NablaCore

public struct ImageFile: Media, Equatable, Hashable {
    public let fileName: String
    public let fileUrl: URL
    public let size: MediaSize?
    public let imageMimeType: MimeType.Image

    public var mimeType: MimeType {
        .image(imageMimeType)
    }

    public init(fileName: String, fileUrl: URL, size: MediaSize?, mimeType: MimeType.Image) {
        self.fileName = fileName
        self.fileUrl = fileUrl
        self.size = size
        imageMimeType = mimeType
    }
}
