import NablaUtils
import UIKit

public protocol IAPViewControllerDelegate: AnyObject {
    func iapViewController(_ viewController: IAPViewController, didSucceedWithToken token: String)
}

public class IAPViewController: UIViewController {
    // MARK: - Public
    
    public init(
        configuration: IAPClient.Configuration,
        delegate: IAPViewControllerDelegate
    ) {
        iap = IAPClient(configuration: configuration)
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private let iap: IAPClient
    
    private weak var delegate: IAPViewControllerDelegate?
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "IAP"
        view.textAlignment = .center
        return view
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }()
    
    private let errorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .red
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var retryButton: UIButton = {
        let view = UIButton()
        view.setTitle("Retry", for: .normal)
        view.addTarget(self, action: #selector(retryButtonHandler), for: .touchUpInside)
        return view
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubviews()
        set(error: nil)
        set(loading: true)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // `authenticate` must be called after the view has appeared because of Google making assumptions about the UI state...
        authenticate()
    }
    
    private func setUpSubviews() {
        let vstack = UIStackView(arrangedSubviews: [
            titleLabel,
            loadingIndicator,
            errorLabel,
            retryButton,
        ])
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.spacing = 8
        view.addSubview(vstack)
        vstack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vstack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            vstack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    private func set(error: Error?) {
        if let error = error {
            errorLabel.isHidden = false
            retryButton.isHidden = false
            errorLabel.text = String(describing: error)
        } else {
            errorLabel.isHidden = true
            retryButton.isHidden = true
        }
    }
    
    private func set(loading: Bool) {
        loadingIndicator.isHidden = !loading
    }
    
    private func authenticate() {
        set(error: nil)
        set(loading: true)
        
        iap.authenticate(from: self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(token):
                self.delegate?.iapViewController(self, didSucceedWithToken: token)
            case let .failure(error):
                self.set(error: error)
                self.set(loading: false)
            }
        }
    }
    
    @objc private func retryButtonHandler() {
        authenticate()
    }
}
