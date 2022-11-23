import UIKit

public extension NablaViews {
    class ImageView: UIImageView {
        // MARK: - Public

        public var source: ImageSource? {
            didSet {
                switch source {
                case .none:
                    image = nil
                    url = nil
                case let .some(.data(data)):
                    url = nil
                    image = UIImage(data: data)
                case let .url(url):
                    self.url = url
                }
            }
        }
        
        // MARK: - Private

        private static var cache: URLCache = URLCacheImplementation()

        private var url: URL? {
            didSet {
                guard url != oldValue else { return }
                update(url: url)
            }
        }

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
