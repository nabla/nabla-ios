import Apollo
import Foundation

enum Normalization {
    static func cacheKey(for object: JSONObject) -> String? {
        guard let rawId = object["id"] as? String else { return nil }
        
        // If `id` is uuid, that's enough
        if let uuid = GQL.UUID(uuidString: rawId) {
            return uuid.uuidString
        }
        
        // Otherwise, mix `id` and `__typename`
        guard let typename = object["__typename"] as? String else { return nil }
        return "\(rawId)_\(typename)"
    }
}
