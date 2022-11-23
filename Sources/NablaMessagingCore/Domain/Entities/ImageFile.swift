import Foundation
import NablaCore

public struct ImageFile: Media, Equatable, Hashable {
    public let fileName: String
    public let source: ImageSource
    public let size: MediaSize?
    public let imageMimeType: MimeType.Image

    public var mimeType: MimeType {
        .image(imageMimeType)
    }
    
    public var content: MediaSource {
        source.asMedia()
    }

    public init(fileName: String, source: ImageSource, size: MediaSize?, mimeType: MimeType.Image) {
        self.fileName = fileName
        self.source = source
        self.size = size
        imageMimeType = mimeType
    }
}
