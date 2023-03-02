import NablaCore
import UIKit

final class ScrollableContainerView: UIView {
    // MARK: - Internal
    
    enum VerticalAlignment {
        case top
        case center
    }
    
    let contentView = UIView()
    
    let alignment: VerticalAlignment
    
    var contentInset: UIEdgeInsets {
        get { scrollView.contentInset }
        set {
            scrollView.contentInset = newValue
            setNeedsUpdateConstraints()
        }
    }
    
    // MARK: Init
    
    init(alignment: VerticalAlignment) {
        self.alignment = alignment
        super.init(frame: .infinite)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    // MARK: Subviews
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var containerHeightConstraint = containerView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
    private lazy var containerWidthConstraint = containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    
    private func setUp() {
        addSubview(scrollView)
        scrollView.nabla.pinToSuperView()
        
        scrollView.addSubview(containerView)
        containerView.nabla.pin(to: scrollView.contentLayoutGuide)
        NSLayoutConstraint.activate([
            containerHeightConstraint,
            containerWidthConstraint,
        ])
        
        containerView.addSubview(contentView)
        
        switch alignment {
        case .top:
            contentView.nabla.pinToSuperView(edges: [.leading, .trailing, .top])
            NSLayoutConstraint.activate([
                contentView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor),
            ])
        case .center:
            contentView.nabla.pinToSuperView(edges: [.leading, .trailing])
            contentView.nabla.constraintToCenterInSuperView()
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        containerHeightConstraint.constant = -contentInset.nabla.vertical
        containerWidthConstraint.constant = -contentInset.nabla.horizontal
    }
}
