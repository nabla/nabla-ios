import Foundation

// sourcery: AutoMockable
protocol DeviceLocalDataSource: AnyObject {
    var deviceId: UUID? { get set }
    var deviceModel: String { get }
    var deviceOSVersion: String { get }
    var codeVersion: Int { get }
}
