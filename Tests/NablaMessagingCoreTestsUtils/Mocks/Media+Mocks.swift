import Foundation
import NablaMessagingCore

public extension Media {
    static var mockImage: Self {
        .init(type: .image, fileName: .filenameStub, fileUrl: .stubImage, thumbnailUrl: .stubImage, mimeType: .image(.jpg), size: .init(width: 200, height: 200))
    }

    static var mockDocument: Self {
        .init(type: .pdf, fileName: .filenameStub, fileUrl: .stubImage, thumbnailUrl: .stubImage, mimeType: .document(.pdf), size: nil)
    }

    static var mockAudioFile: Self {
        .init(type: .audio, fileName: .filenameStub, fileUrl: .stubImage, thumbnailUrl: nil, mimeType: .audio(.mpeg), size: nil)
    }

    static var mockVideo: Self {
        .init(type: .video, fileName: .filenameStub, fileUrl: .stubVideo, thumbnailUrl: nil, mimeType: .video(.mp4), size: .init(width: 700, height: 394))
    }
}
