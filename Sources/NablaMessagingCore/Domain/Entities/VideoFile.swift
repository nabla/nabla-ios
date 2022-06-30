import Foundation
import NablaCore

public struct VideoFile: Media, Equatable, Hashable {
    public let fileName: String
    public let fileUrl: URL
    public let size: MediaSize?
    public let videoMimeType: MimeType.Video

    public var mimeType: MimeType {
        .video(videoMimeType)
    }

    public init(fileName: String, fileUrl: URL, size: MediaSize?, mimeType: MimeType.Video) {
        self.fileName = fileName
        self.fileUrl = fileUrl
        self.size = size
        videoMimeType = mimeType
    }
}
