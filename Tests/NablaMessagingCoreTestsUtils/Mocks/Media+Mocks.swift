import Foundation
import NablaMessagingCore

public extension Media {
    static var mockImage: Self {
        .init(type: .image, fileName: .filenameStub, fileUrl: .stub, thumbnailUrl: .stub, mimeType: .png)
    }

    static var mockDocument: Self {
        .init(type: .pdf, fileName: .filenameStub, fileUrl: .stub, thumbnailUrl: .stub, mimeType: .pdf)
    }

    static var mockAudioFile: Self {
        .init(type: .audio, fileName: .filenameStub, fileUrl: .stub, thumbnailUrl: nil, mimeType: .mpeg)
    }
}
