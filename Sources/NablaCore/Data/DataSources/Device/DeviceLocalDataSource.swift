import Foundation

// sourcery: AutoMockable
protocol DeviceLocalDataSource: AnyObject {
    func getDeviceId(forUserId userId: String) -> UUID?
    func setDeviceId(_ deviceId: UUID, forUserId userId: String)
    func getSentryConfiguration() -> SentryConfiguration?
    func setSentryConfiguration(_ configuration: SentryConfiguration)
    var deviceModel: String { get }
    var deviceOSVersion: String { get }
    var codeVersion: Int { get }
}
