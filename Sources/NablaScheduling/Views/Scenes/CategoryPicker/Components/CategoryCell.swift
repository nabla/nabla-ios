import NablaCore
import UIKit

final class CategoryCell: UITableViewCell, Reusable {
    // MARK: - Internal
    
    var text: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    // MARK: - Private
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = NablaTheme.CategoryPickerViewTheme.CellTheme.borderColor.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = NablaTheme.CategoryPickerViewTheme.CellTheme.textColor
        view.font = NablaTheme.CategoryPickerViewTheme.CellTheme.font
        return view
    }()
    
    private lazy var indicatorView: UIView = {
        let view = UIImageView(image: .nabla.symbol(.chevronRight))
        view.tintColor = NablaTheme.CategoryPickerViewTheme.CellTheme.indicatorColor
        view.contentMode = .scaleAspectFit
        view.nabla.constraintToSize(CGSize(width: 18, height: 18))
        return view
    }()
    
    private func setUp() {
        backgroundColor = .clear
        
        let hstack = UIStackView(arrangedSubviews: [label, indicatorView])
        hstack.axis = .horizontal
        hstack.distribution = .fill
        hstack.alignment = .center
        hstack.spacing = 8
        containerView.addSubview(hstack)
        hstack.nabla.pinToSuperView(insets: .nabla.all(12))
        
        contentView.addSubview(containerView)
        containerView.nabla.pinToSuperView(insets: .init(top: 8, leading: 16, bottom: 0, trailing: 16))
    }
    
    override func setSelected(_: Bool, animated _: Bool) {
        // Do nothing
    }
    
    override func setHighlighted(_ highlighted: Bool, animated _: Bool) {
        containerView.alpha = highlighted ? 0.5 : 1
    }
}
