import Combine
import NablaCore
import UIKit

final class AppointmentCell: DynamicHeightCell, Reusable {
    // MARK: - Internal
    
    @ObservedViewModel var viewModel: AppointmentCellViewModel? {
        didSet { setUpViewModel() }
    }
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
        update()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpSubviews()
        update()
    }
    
    // MARK: - Private
    
    private var viewModelObserver: AnyCancellable?
    
    // MARK: Subviews
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = NablaTheme.AppointmentListViewTheme.CellTheme.backgroundColor
        view.layer.cornerRadius = NablaTheme.AppointmentListViewTheme.CellTheme.cornerRadius
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = NablaTheme.AppointmentListViewTheme.CellTheme.titleFont
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = NablaTheme.AppointmentListViewTheme.CellTheme.subtitleFont
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private lazy var avatarView: NablaViews.AvatarView = {
        let view = NablaViews.AvatarView()
        view.nabla.constraintToSize(CGSize(width: 32, height: 32))
        return view
    }()
    
    private(set) lazy var secondaryActionsButton: UIButton = {
        let view = UIButton()
        view.setImage(.nabla.symbol(.ellipsis), for: .normal)
        view.tintColor = NablaTheme.AppointmentListViewTheme.CellTheme.moreButtonColor
        view.addTarget(self, action: #selector(secondaryButtonHandler), for: .touchUpInside)
        return view
    }()
    
    private lazy var primaryActionButton: NablaViews.PrimaryButton = {
        let view = NablaViews.PrimaryButton()
        view.theme = NablaTheme.AppointmentListViewTheme.CellTheme.button
        view.onTap = { [weak self] in
            self?.viewModel?.userDidTapPrimaryActionButton()
        }
        return view
    }()
    
    private func setUpSubviews() {
        backgroundColor = .clear
        
        let labelVStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelVStack.axis = .vertical
        labelVStack.distribution = .fill
        labelVStack.alignment = .leading
        labelVStack.spacing = 0
        
        let hstack = UIStackView(arrangedSubviews: [avatarView, labelVStack, secondaryActionsButton])
        hstack.axis = .horizontal
        hstack.distribution = .fill
        hstack.alignment = .center
        hstack.spacing = 8
        
        let vstack = UIStackView(arrangedSubviews: [hstack, primaryActionButton])
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.alignment = .fill
        vstack.spacing = 16
        
        containerView.addSubview(vstack)
        vstack.nabla.pinToSuperView(insets: .nabla.all(16))
        
        contentView.addSubview(containerView)
        containerView.nabla.pinToSuperView(insets: .init(top: 12, leading: 16, bottom: 0, trailing: 16), priority: .defaultHigh)
    }
    
    private func setUpViewModel() {
        // Cells are recycled, it is important to stop listening to previous VM.
        viewModelObserver?.cancel()
        
        viewModelObserver = _viewModel.onChange { [weak self] _ in
            self?.update()
        }
    }
    
    private func update() {
        guard let viewModel = viewModel else { return }
        
        avatarView.avatar = viewModel.avatar
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        if let primaryActionTitle = viewModel.primaryActionTitle {
            setPrimaryButtonHidden(false)
            primaryActionButton.setTitle(primaryActionTitle, for: .normal)
        } else {
            setPrimaryButtonHidden(true)
        }
        
        if viewModel.enabled {
            titleLabel.textColor = NablaTheme.AppointmentListViewTheme.CellTheme.titleColor
            subtitleLabel.textColor = NablaTheme.AppointmentListViewTheme.CellTheme.subtitleColor
        } else {
            titleLabel.textColor = NablaTheme.AppointmentListViewTheme.CellTheme.titleDisabledColor
            subtitleLabel.textColor = NablaTheme.AppointmentListViewTheme.CellTheme.subtitleDisabledColor
        }
        
        secondaryActionsButton.isHidden = !viewModel.showSecondaryActionsButton
    }
    
    private func setPrimaryButtonHidden(_ hidden: Bool) {
        guard primaryActionButton.isHidden != hidden else { return }
        primaryActionButton.isHidden = hidden
        setNeedsHeightUpdate()
    }
    
    // MARK: Handlers
    
    @objc private func secondaryButtonHandler() {
        viewModel?.userDidTapSecondaryActionsButton()
    }
}
