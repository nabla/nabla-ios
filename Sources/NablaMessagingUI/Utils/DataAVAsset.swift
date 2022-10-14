import AVKit
import Foundation
import NablaCore

final class DataAVAsset: AVURLAsset {
    private var file: TemporaryMediaFile?

    convenience init(source: MediaSource) throws {
        switch source {
        case let .url(url):
            self.init(url: url)
        case let .data(data):
            let file = try TemporaryMediaFile(with: data)
            self.init(url: file.url)
            self.file = file
        }
    }
}
