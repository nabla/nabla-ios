import Foundation

public struct AudioFile: Hashable {
    public let media: Media
    public let durationMs: Int

    public init(
        media: Media,
        durationMs: Int
    ) {
        self.media = media
        self.durationMs = durationMs
    }
}
