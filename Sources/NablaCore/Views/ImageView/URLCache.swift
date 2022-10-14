import Foundation

public protocol URLCache {
    func get(_ key: URL) -> NSData?
    func set(_ key: URL, newValue: NSData?)
    func loadFrom(url: URL, completion: @escaping (NSData?) -> Void) -> URLSessionDataTask?
}

public struct URLCacheImplementation: URLCache {
    let cache = NSCache<NSURL, NSData>()

    public init() {}
    
    public func get(_ key: URL) -> NSData? {
        cache.object(forKey: key as NSURL)
    }
    
    public func set(_ key: URL, newValue: NSData?) {
        if let newValue = newValue {
            cache.setObject(newValue, forKey: key as NSURL)
        } else {
            cache.removeObject(forKey: key as NSURL)
        }
    }
    
    public func loadFrom(url: URL, completion: @escaping (NSData?) -> Void) -> URLSessionDataTask? {
        if let cachedData = get(url) {
            completion(cachedData)
            return nil
        }
        if url.isFileURL {
            let data = readLocalImage(url: url)
            completion(data)
            return nil
        } else {
            return fetchRemoteImage(url: url, completion: completion)
        }
    }
    
    private func readLocalImage(url: URL) -> NSData? {
        let fileManager = FileManager()
        guard fileManager.isReadableFile(atPath: url.path) else { return nil }
        guard let data = fileManager.contents(atPath: url.path) else { return nil }
        return data as NSData
    }
    
    private func fetchRemoteImage(url: URL, completion: @escaping (NSData?) -> Void) -> URLSessionDataTask? {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            
            let nsData = NSData(data: data)
            self.set(url, newValue: nsData)
            completion(nsData)
        }
    }
}
