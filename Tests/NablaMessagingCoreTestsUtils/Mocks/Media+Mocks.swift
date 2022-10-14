import Foundation
import NablaMessagingCore

public extension ImageFile {
    static var mock: Self {
        .init(fileName: .filenameStub, content: .url(.stubImage), size: .init(width: 200, height: 200), mimeType: .jpg)
    }
}

public extension AudioFile {
    static var mock: Self {
        .init(fileName: .filenameStub, content: .url(.stubImage), durationMs: 1000, mimeType: .mpeg)
    }
}

public extension DocumentFile {
    static var mock: Self {
        .init(fileName: .filenameStub, content: .url(.stubImage), thumbnailUrl: .stubImage, mimeType: .pdf)
    }
}

public extension VideoFile {
    static var mock: Self {
        .init(fileName: .filenameStub, content: .url(.stubVideo), size: .init(width: 700, height: 394), mimeType: .mp4)
    }
}
