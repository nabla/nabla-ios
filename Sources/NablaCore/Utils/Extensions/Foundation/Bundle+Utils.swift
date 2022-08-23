import Foundation

extension Bundle: NablaExtendable {}

public extension NablaExtension where Base: Bundle {
    var hasMicrophoneUsageDescription: Bool {
        base.object(forInfoDictionaryKey: "NSMicrophoneUsageDescription") as? String != nil
    }
    
    var hasCameraUsageDescription: Bool {
        base.object(forInfoDictionaryKey: "NSCameraUsageDescription") as? String != nil
    }
}
