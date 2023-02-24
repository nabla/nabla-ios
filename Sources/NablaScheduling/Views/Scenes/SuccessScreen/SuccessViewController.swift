import NablaCore
import UIKit

final class SuccessViewController: UIViewController {
    // MARK: - Internal
    
    // MARK: Init
    
    init(viewModel: SuccessViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Private
    
    @ObservedViewModel private var viewModel: SuccessViewModel
    
    // MARK: Subviews
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = .nabla.symbol(.checkmarkCircle)
        view.tintColor = NablaTheme.SuccessTheme.imageColor
        view.nabla.constraintToSize(58)
        return view
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = L10n.successScreenLabel
        view.textColor = NablaTheme.SuccessTheme.messageColor
        view.font = NablaTheme.SuccessTheme.messageFont
        return view
    }()
    
    private lazy var button: NablaViews.PrimaryButton = {
        let view = NablaViews.PrimaryButton()
        view.setTitle(L10n.successScreenButton, for: .normal)
        view.theme = NablaTheme.SuccessTheme.button
        view.onTap = { [weak self] in
            self?.viewModel.userDidTapActionButton()
        }
        return view
    }()
    
    private func setUp() {
        view.backgroundColor = NablaTheme.SuccessTheme.backgroundColor
        
        let vstack = UIStackView(arrangedSubviews: [imageView, label])
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.distribution = .fill
        vstack.spacing = 16
        view.addSubview(vstack)
        vstack.nabla.constraintToCenter(in: view.safeAreaLayoutGuide)
        
        view.addSubview(button)
        button.nabla.pin(
            to: view.safeAreaLayoutGuide,
            edges: [.leading, .trailing, .bottom],
            insets: .nabla.all(16)
        )
    }
}
