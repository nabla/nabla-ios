import UIKit

public extension NablaViews {
    class URLImageView: UIImageView {
        // MARK: - Public
        
        public var url: URL? {
            didSet {
                guard url != oldValue else { return }
                update(url: url)
            }
        }
        
        public static var cache: URLCache = URLCacheImplementation()
        
        // MARK: - Private
        
        private func update(url: URL?) {
            image = nil
            
            guard let url = url else { return }
            
            Self.cache.loadFrom(url: url) { data in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if let data = data, url == self.url {
                        self.image = UIImage(data: data as Data)
                    }
                }
            }?.resume()
        }
    }
}
