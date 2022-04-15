import UIKit

final class UserLobbyViewController: UIViewController, UserLobbyViewContract {
    // MARK: - Internal
    
    var presenter: UserLobbyPresenter?
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func set(error: String?) {
        if let error = error {
            errorLabel.isHidden = false
            retryButton.isHidden = false
            errorLabel.text = error
        } else {
            errorLabel.isHidden = true
            retryButton.isHidden = true
        }
    }
    
    func set(loading: Bool) {
        loadingIndicator.isHidden = !loading
    }
    
    // MARK: - Private
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
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
        presenter?.start()
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
    
    @objc private func retryButtonHandler() {
        presenter?.userDidTapRetryButton()
    }
}
