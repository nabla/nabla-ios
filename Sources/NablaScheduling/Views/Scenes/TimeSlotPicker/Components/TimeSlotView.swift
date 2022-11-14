import NablaCore
import UIKit

final class TimeSlotView: UIControl {
    // MARK: - Internal
    
    var date: Date = .init() {
        didSet { update() }
    }
    
    override var isSelected: Bool {
        didSet { update() }
    }
    
    var onTap: (() -> Void)?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        update()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        update()
    }
    
    // MARK: Life cycle
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        update()
    }
    
    // MARK: - Private
    
    private typealias Theme = NablaTheme.TimeSlotPickerViewTheme.CellTheme.ButtonTheme
    
    // MARK: Subviews
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = Theme.font
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }()
    
    private func setUp() {
        layer.borderWidth = 1
        layer.cornerRadius = 8
        
        addSubview(label)
        label.nabla.pinToSuperView(insets: .nabla.all(6))
        
        addTarget(self, action: #selector(tapHandler), for: .touchUpInside)
    }
    
    // MARK: Format
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    private func update() {
        label.text = Self.formatter.string(from: date)
        label.textColor = isSelected ? Theme.selectedTextColor : Theme.textColor
        backgroundColor = isSelected ? Theme.selectedBackgroundColor : Theme.backgroundColor
        layer.borderColor = (isSelected ? Theme.selectedBorderColor : Theme.borderColor).cgColor
    }
    
    // MARK: Handlers
    
    @objc private func tapHandler() {
        onTap?()
    }
}
