import Foundation
import NablaCore

public struct AudioFile: Media, Equatable, Hashable {
    public let fileName: String
    public let fileUrl: URL
    public let durationMs: Int
    public let audioMimeType: MimeType.Audio

    public var mimeType: MimeType {
        .audio(audioMimeType)
    }

    public init(fileName: String, fileUrl: URL, durationMs: Int, mimeType: MimeType.Audio) {
        self.fileName = fileName
        self.fileUrl = fileUrl
        self.durationMs = durationMs
        audioMimeType = mimeType
    }
}
