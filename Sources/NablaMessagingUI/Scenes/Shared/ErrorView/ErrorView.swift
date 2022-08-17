import Foundation
import NablaCore
import UIKit

protocol ErrorViewDelegate: AnyObject {
    func errorViewDidTapButton(_ view: ErrorView)
}

final class ErrorView: UIView {
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    weak var delegate: ErrorViewDelegate?
    
    func configure(with viewModel: ErrorViewModel) {
        label.text = viewModel.message
        button.setTitle(viewModel.buttonTitle, for: .normal)
        button.isHidden = viewModel.buttonTitle == nil
    }
    
    // MARK: - Private
    
    private lazy var label: UILabel = makeLabel()
    private lazy var button: UIButton = makeButton()
    
    private func setUp() {
        let stackView = UIStackView(arrangedSubviews: [label, button])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.nabla.constraintToCenterInSuperView(insets: .init(x: 8, y: 8))
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = NablaTheme.ErrorView.labelColor
        label.font = NablaTheme.ErrorView.labelFont
        return label
    }
    
    private func makeButton() -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        button.setTitleColor(NablaTheme.ErrorView.retryButtonTitleColor, for: .normal)
        button.titleLabel?.font = NablaTheme.ErrorView.retryButtonTitleFont
        return button
    }
    
    @objc private func buttonDidTap(_: UIButton) {
        delegate?.errorViewDidTapButton(self)
    }
}
