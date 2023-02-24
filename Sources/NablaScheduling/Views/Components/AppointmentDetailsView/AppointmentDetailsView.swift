import NablaCore
import UIKit

public final class AppointmentDetailsView: UIView {
    // MARK: - Internal
    
    var theme: Theme {
        didSet { updateTheme() }
    }
    
    var avatar: AvatarViewModel {
        get { avatarView.avatar }
        set { avatarView.avatar = newValue }
    }
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    var locationType: LocationType = .remote {
        didSet {
            locationAccessoryView.image = image(for: locationType)
            locationAccessoryView.title = title(for: locationType)
        }
    }
    
    var location: String? {
        get { locationAccessoryView.subtitle }
        set { locationAccessoryView.subtitle = newValue }
    }
    
    var locationDetails: String? {
        get { locationAccessoryView.extra }
        set { locationAccessoryView.extra = newValue }
    }
    
    var date: Date = .init() {
        didSet { dateAccessoryView.title = format(date: date) }
    }
    
    var price: String? {
        get { priceAccessoryView.title }
        set {
            priceAccessoryView.title = newValue
            priceAccessoryView.isHidden = newValue == nil
        }
    }
    
    var onLocationTap: (() -> Void)?
    
    // MARK: Init
    
    init(frame: CGRect, theme: Theme) {
        self.theme = theme
        super.init(frame: frame)
        setUp()
        updateTheme()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    // MARK: Subviews
    
    private lazy var avatarView: NablaViews.AvatarView = {
        let view = NablaViews.AvatarView()
        view.nabla.constraintToSize(72)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var accessorySeparator: UIView = {
        let view = UIView()
        view.nabla.constraintHeight(1)
        view.backgroundColor = theme.separatorColor
        return view
    }()
    
    private lazy var accessoryContainer: UIView = {
        let view = UIStackView(arrangedSubviews: [
            locationAccessoryView,
            dateAccessoryView,
            priceAccessoryView,
        ])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.spacing = 8
        return view
    }()
    
    private lazy var locationAccessoryView: AppointmentDetailsAccessoryView = {
        let view = AppointmentDetailsAccessoryView(theme: theme.accessoriesTheme)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(locationTapHandler))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    private lazy var dateAccessoryView: AppointmentDetailsAccessoryView = {
        let view = AppointmentDetailsAccessoryView(theme: theme.accessoriesTheme)
        view.image = .nabla.symbol(.calendar)
        return view
    }()
    
    private lazy var priceAccessoryView: AppointmentDetailsAccessoryView = {
        let view = AppointmentDetailsAccessoryView(theme: theme.accessoriesTheme)
        view.image = .nabla.symbol(.dollarSignCircle)
        return view
    }()
    
    private func setUp() {
        let vstack = UIStackView(arrangedSubviews: [
            avatarView,
            titleLabel,
            subtitleLabel,
        ])
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.distribution = .fill
        addSubview(vstack)
        vstack.nabla.pinToSuperView(edges: [.leading, .top, .trailing], insets: .nabla.all(20))
        vstack.setCustomSpacing(12, after: avatarView)
        vstack.setCustomSpacing(4, after: titleLabel)
        vstack.setCustomSpacing(12, after: subtitleLabel)
        
        addSubview(accessorySeparator)
        accessorySeparator.nabla.pinToSuperView(edges: [.leading, .trailing])
        
        addSubview(accessoryContainer)
        accessoryContainer.nabla.pinToSuperView(edges: [.leading, .bottom, .trailing], insets: .nabla.all(20))
        
        NSLayoutConstraint.activate([
            accessorySeparator.topAnchor.constraint(equalTo: vstack.bottomAnchor, constant: 20),
            accessoryContainer.topAnchor.constraint(equalTo: accessorySeparator.bottomAnchor, constant: 20),
        ])
    }
    
    private func updateTheme() {
        backgroundColor = theme.backgroundColor
        layer.cornerRadius = theme.cornerRadius
        
        titleLabel.textColor = theme.doctorNameColor
        titleLabel.font = theme.doctorNameFont
        
        subtitleLabel.textColor = theme.doctorDescriptionColor
        subtitleLabel.font = theme.doctorDescriptionFont
        
        accessorySeparator.backgroundColor = theme.separatorColor
        locationAccessoryView.theme = theme.accessoriesTheme
        dateAccessoryView.theme = theme.accessoriesTheme
        priceAccessoryView.theme = theme.accessoriesTheme
    }
    
    private func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.formattingContext = .beginningOfSentence
        formatter.doesRelativeDateFormatting = true
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func image(for locationType: LocationType) -> UIImage {
        switch locationType {
        case .physical: return .nabla.symbol(.house)
        case .remote: return .nabla.symbol(.video)
        }
    }
    
    private func title(for locationType: LocationType) -> String {
        switch locationType {
        case .physical: return L10n.appointmentDetailsViewPhysicalLocationLabel
        case .remote: return L10n.appointmentDetailsViewRemoteLocationLabel
        }
    }
    
    @objc private func locationTapHandler() {
        onLocationTap?()
    }
}
