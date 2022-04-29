import Foundation
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
        stackView.centerInSuperView()
        stackView.pinToSuperView(edges: .horizontal, insets: .all(8), priority: .defaultHigh)
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
    
    private func makeButton() -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }
    
    @objc private func buttonDidTap(_: UIButton) {
        delegate?.errorViewDidTapButton(self)
    }
}
