import Foundation

struct SentryConfiguration: Codable, Equatable {
    let dsn: String
    let env: String
}
