import Foundation
import NablaCore

public struct VideoFile: Media, Equatable, Hashable {
    public let fileName: String
    public let content: MediaContent
    public let size: MediaSize?
    public let videoMimeType: MimeType.Video

    public var mimeType: MimeType {
        .video(videoMimeType)
    }

    public init(fileName: String, content: MediaContent, size: MediaSize?, mimeType: MimeType.Video) {
        self.fileName = fileName
        self.content = content
        self.size = size
        videoMimeType = mimeType
    }
}
