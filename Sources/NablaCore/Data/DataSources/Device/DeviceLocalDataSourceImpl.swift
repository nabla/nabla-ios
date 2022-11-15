import Foundation
import UIKit

final class DeviceLocalDataSourceImpl: DeviceLocalDataSource {
    // MARK: - Internal
    
    var deviceId: UUID? {
        get { try? store.get(forKey: Keys.deviceIdKey) }
        set { try? store.set(newValue, forKey: Keys.deviceIdKey) }
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
        store: KeyValueStore,
        logger: Logger
    ) {
        self.store = store
        self.logger = logger
    }
    
    // MARK: - Private
    
    private enum Keys {
        static let deviceIdKey = "DeviceLocalDataSourceImpl.deviceIdKey"
    }

    private let store: KeyValueStore
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
            logger.error(message: "Failed to read code version", extra: ["error": error])
            return 0
        }
    }
}

private struct VersionsFile: Codable {
    let codeVersion: Int
}
