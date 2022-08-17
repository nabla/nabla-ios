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
        guard let url = NablaCorePackage.resourcesBundle.url(forResource: "versions", withExtension: "json") else { return 0 }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let data = try Data(contentsOf: url)
            let file = try decoder.decode(VersionsFile.self, from: data)
            return file.codeVersion
        } catch {
            logger.error(message: "Failed to read code version", extra: ["error": error])
            return 0
        }
    }
}

private struct VersionsFile: Codable {
    let codeVersion: Int
}
