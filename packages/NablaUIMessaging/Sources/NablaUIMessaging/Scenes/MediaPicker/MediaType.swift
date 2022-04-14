import Foundation
import MobileCoreServices

public enum MediaType: CaseIterable {
    case image
    case video
}

extension MediaType {
    var utTypes: Set<String> {
        switch self {
        case .image:
            return [
                kUTTypeImage as String,
            ]
        case .video:
            return [
                kUTTypeVideo as String,
                kUTTypeMovie as String,
            ]
        }
    }
}
