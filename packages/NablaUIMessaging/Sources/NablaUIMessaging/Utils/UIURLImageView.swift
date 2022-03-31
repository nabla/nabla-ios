import NablaCore
import NablaUtils
import UIKit

public class UIURLImageView: UIImageView {
    // MARK: Public

    public var url: URL? {
        didSet {
            guard url != oldValue else { return }
            update(url: url)
        }
    }

    // MARK: - Private

    @Inject private var cache: NablaCore.URLCache

    private func update(url: URL?) {
        image = nil

        guard let url = url else { return }

        cache.loadFrom(url: url) { data in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if let data = data, url == self.url {
                    self.image = UIImage(data: data as Data)
                }
            }
        }?.resume()
    }
}
