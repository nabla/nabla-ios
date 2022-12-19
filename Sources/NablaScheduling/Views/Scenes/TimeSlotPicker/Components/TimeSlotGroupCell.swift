import NablaCore
import UIKit

final class TimeSlotGroupCell: UITableViewCell, Reusable {
    // MARK: - Internal
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    var timeSlots: [TimeSlotViewItem] {
        get { gridView.items }
        set { gridView.items = newValue }
    }
    
    var isOpened: Bool = true {
        didSet {
            indicatorView.isHighlighted = isOpened
            subtitleLabel.isHidden = isOpened
            gridView.isHidden = !isOpened
            vstack.spacing = isOpened ? 12 : 4
        }
    }
    
    var onTapTimeSlot: ((_ item: TimeSlotViewItem, _ index: Int) -> Void)?
    
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
    
    // MARK: Overrides
    
    override func setHighlighted(_ highlighted: Bool, animated _: Bool) {
        UIView.animate(withDuration: 0.25) { [containerView] in
            containerView.alpha = highlighted ? 0.5 : 1
        }
    }
    
    override func setSelected(_: Bool, animated _: Bool) {
        // Do nothing
    }
    
    // MARK: Subviews
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = NablaTheme.TimeSlotPickerViewTheme.CellTheme.backgroundColor
        view.layer.cornerRadius = NablaTheme.TimeSlotPickerViewTheme.CellTheme.cornerRadius
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = NablaTheme.TimeSlotPickerViewTheme.CellTheme.titleFont
        view.textColor = NablaTheme.TimeSlotPickerViewTheme.CellTheme.titleColor
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.font = NablaTheme.TimeSlotPickerViewTheme.CellTheme.subtitleFont
        view.textColor = NablaTheme.TimeSlotPickerViewTheme.CellTheme.subtitleColor
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }()
    
    private lazy var indicatorView: UIImageView = {
        let view = UIImageView(
            image: .nabla.symbol(.chevronDown),
            highlightedImage: .nabla.symbol(.chevronUp)
        )
        view.contentMode = .scaleAspectFit
        view.tintColor = NablaTheme.TimeSlotPickerViewTheme.CellTheme.indicatorColor
        view.nabla.constraintToSize(18)
        return view
    }()
    
    private lazy var gridView: GridView<TimeSlotView, TimeSlotViewItem> = {
        let view = GridView<TimeSlotView, TimeSlotViewItem>(columns: 3) { [weak self] view, index, timeSlot in
            view.date = timeSlot.date
            view.isSelected = timeSlot.selected
            view.onTap = {
                self?.onTapTimeSlot?(timeSlot, index)
            }
        }
        return view
    }()
    
    private lazy var vstack: UIStackView = {
        let hstack = UIStackView(arrangedSubviews: [titleLabel, indicatorView])
        hstack.axis = .horizontal
        hstack.distribution = .fill
        hstack.alignment = .center
        hstack.spacing = 8
        
        let vstack = UIStackView(arrangedSubviews: [hstack, subtitleLabel, gridView])
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.alignment = .fill
        vstack.spacing = 4 // Controlled by `isOpened`
        return vstack
    }()
    
    private func setUp() {
        backgroundColor = .clear
        
        containerView.addSubview(vstack)
        vstack.nabla.pinToSuperView(insets: .nabla.all(12))
        
        contentView.addSubview(containerView)
        containerView.nabla.pinToSuperView(
            edges: [.leading, .top, .trailing],
            insets: .init(top: 12, leading: 16, bottom: 0, trailing: 16)
        )
        // We define the bottom constraint as `lessThanOrEqualTo` with a lower priority to improve the open/close animation
        let bottomConstraint = containerView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
    }
    
    // MARK: Handlers
}
