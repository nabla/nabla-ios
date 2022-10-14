import Foundation
import NablaCore

public struct AudioFile: Media, Equatable, Hashable {
    public let fileName: String
    public let content: MediaContent
    public let durationMs: Int
    public let audioMimeType: MimeType.Audio

    public var mimeType: MimeType {
        .audio(audioMimeType)
    }

    public init(fileName: String, content: MediaContent, durationMs: Int, mimeType: MimeType.Audio) {
        self.fileName = fileName
        self.content = content
        self.durationMs = durationMs
        audioMimeType = mimeType
    }
}
