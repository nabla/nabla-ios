import Foundation
import NablaCore
import NablaMessagingCore

enum MediaContentTransformer {
    static func transform(_ mediaContent: MediaContent) -> MediaSource {
        switch mediaContent {
        case let .data(data): return .data(data)
        case let .url(url): return .url(url)
        }
    }
}
