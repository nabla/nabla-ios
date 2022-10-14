import Foundation

class TemporaryMediaFile {
    let url: URL
    
    init(with data: Data) throws {
        let fileName = UUID().uuidString
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        try data.write(to: url)
        self.url = url
    }
    
    func deleteFile() {
        try? FileManager.default.removeItem(at: url)
    }

    deinit {
        self.deleteFile()
    }
}
