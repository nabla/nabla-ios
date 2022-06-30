import Foundation
import NablaCore

/// Medias are a representation of a file.
/// Those can be created with a local fileUrl, or a remote one.

public struct MediaSize: Hashable {
    public let width: Int
    public let height: Int

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

public protocol Media {
    var fileName: String { get }
    var fileUrl: URL { get }
    var mimeType: MimeType { get }
}
