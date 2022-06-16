import Foundation
import NablaMessagingCore

public extension Media {
    static var mockImage: Self {
        .init(type: .image, fileName: .filenameStub, fileUrl: .stub, thumbnailUrl: .stub, mimeType: .image(.jpg))
    }

    static var mockDocument: Self {
        .init(type: .pdf, fileName: .filenameStub, fileUrl: .stub, thumbnailUrl: .stub, mimeType: .document(.pdf))
    }

    static var mockAudioFile: Self {
        .init(type: .audio, fileName: .filenameStub, fileUrl: .stub, thumbnailUrl: nil, mimeType: .audio(.mpeg))
    }
}
