import Foundation

// sourcery: AutoMockable
protocol DeviceLocalDataSource: AnyObject {
    func getDeviceId(forUserId userId: String) -> UUID?
    func setDeviceId(_ deviceId: UUID, forUserId userId: String)
    var deviceModel: String { get }
    var deviceOSVersion: String { get }
    var codeVersion: Int { get }
}
