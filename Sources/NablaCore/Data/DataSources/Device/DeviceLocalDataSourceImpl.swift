import Foundation
import UIKit

final class DeviceLocalDataSourceImpl: DeviceLocalDataSource {
    // MARK: - Internal
    
    func getDeviceId(forUserId userId: String) -> UUID? {
        let globalDeviceId: UUID? = try? dangerouslyUnscopedStore.get(forKey: generateKeyForDeviceId(forUserId: userId))
        
        if globalDeviceId == nil, let legacyDeviceId: UUID = try? scopedStore.get(forKey: Keys.deviceIdKey) {
            migrateLegacyDeviceIdToGlobalStorage(legacyDeviceId, forUserId: userId)
            return legacyDeviceId
        }
        
        return globalDeviceId
    }
    
    func setDeviceId(_ deviceId: UUID, forUserId userId: String) {
        try? dangerouslyUnscopedStore.set(deviceId, forKey: generateKeyForDeviceId(forUserId: userId))
    }
    
    func getSentryConfiguration() -> SentryConfiguration? {
        try? scopedStore.get(forKey: Keys.sentryConfigurationKey)
    }
    
    func setSentryConfiguration(_ configuration: SentryConfiguration) {
        try? scopedStore.set(configuration, forKey: Keys.sentryConfigurationKey)
    }
    
    var deviceModel: String {
        if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return "Simulator \(simModelCode)"
        }
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String(validatingUTF8: ptr)
            }
        }
        return modelCode ?? "N/A"
    }
    
    var deviceOSVersion: String {
        UIDevice.current.systemVersion
    }
    
    private(set) lazy var codeVersion: Int = readCodeVersion()
    
    // MARK: Init
    
    init(
        scopedStore: KeyValueStore,
        unscopedStore: KeyValueStore,
        logger: Logger
    ) {
        self.scopedStore = scopedStore
        dangerouslyUnscopedStore = unscopedStore
        self.logger = logger
    }
    
    // MARK: - Private
    
    private enum Keys {
        static let deviceIdKey = "DeviceLocalDataSourceImpl.deviceIdKey"
        static let sentryConfigurationKey = "DeviceLocalDataSourceImpl.sentry.configuration"
    }

    private let scopedStore: KeyValueStore
    /// We store the deviceId in the unscoped storage so that we are sure we always send the same deviceId for a given userId, no matter the SDK instance
    private let dangerouslyUnscopedStore: KeyValueStore
    private let logger: Logger
    
    private func readCodeVersion() -> Int {
        guard let url = NablaCorePackage.resourcesBundle.url(forResource: "version", withExtension: nil) else {
            logger.error(message: "Failed to read code version, unable to find file")
            return 0
        }
        do {
            let data = try Data(contentsOf: url)
            guard let stringValue = String(data: data, encoding: String.Encoding.utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                logger.error(message: "Failed to read code version, unable to extract value")
                return 0
            }
            guard let intValue = Int(stringValue) else {
                logger.error(message: "Failed to read code version, unable to parse value (" + stringValue + ")")
                return 0
            }
            
            return intValue
        } catch {
            logger.error(message: "Failed to read code version", error: error)
            return 0
        }
    }
    
    private func generateKeyForDeviceId(forUserId userId: String) -> String {
        "\(Keys.deviceIdKey)_\(userId.hashValue)"
    }
    
    private func migrateLegacyDeviceIdToGlobalStorage(_ legacyDeviceId: UUID, forUserId userId: String) {
        setDeviceId(legacyDeviceId, forUserId: userId)
        scopedStore.remove(key: Keys.deviceIdKey)
    }
}

private struct VersionsFile: Codable {
    let codeVersion: Int
}
