import NablaCore
import UIKit

final class DisclaimerCell: UITableViewCell, Reusable {
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
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.textColor = NablaTheme.CategoryPickerViewTheme.preselectedLocationDisclaimerTextColor
        view.font = NablaTheme.CategoryPickerViewTheme.preselectedLocationDisclaimerFont
        return view
    }()
    
    private func setUp() {
        backgroundColor = .clear
        
        contentView.addSubview(label)
        label.nabla.pinToSuperView(insets: .init(top: 16, leading: 16, bottom: 4, trailing: 16))
    }
}
