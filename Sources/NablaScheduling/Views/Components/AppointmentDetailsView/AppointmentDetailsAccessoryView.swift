import NablaCore
import UIKit

public final class AppointmentDetailsAccessoryView: UIView {
    // MARK: - Internal
    
    var theme: Theme {
        didSet { updateTheme() }
    }
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { subtitleLabel.text }
        set {
            subtitleLabel.text = newValue
            updateVisibleViews()
        }
    }
    
    var extra: String? {
        get { extraLabel.text }
        set {
            extraLabel.text = newValue
            updateVisibleViews()
        }
    }
    
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    // MARK: Init
    
    init(theme: Theme) {
        self.theme = theme
        super.init(frame: .zero)
        setUp()
        updateTheme()
        updateVisibleViews()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let imageSize = CGSize(width: 20, height: 20)
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.nabla.constraintToSize(Constants.imageSize)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var imagePlaceholder: UIView = {
        let view = UIView()
        view.nabla.constraintToSize(Constants.imageSize)
        return view
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var extraLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var firstRow: UIView = makeRow(with: imageView, titleLabel)
    
    private lazy var secondRow: UIView = {
        let spacer = UIView()
        let vstack = UIStackView(arrangedSubviews: [subtitleLabel, extraLabel])
        vstack.axis = .vertical
        vstack.spacing = 2
        vstack.alignment = .leading
        vstack.distribution = .fill
        return makeRow(with: imagePlaceholder, vstack)
    }()
    
    private func setUp() {
        let vstack = UIStackView(arrangedSubviews: [firstRow, secondRow])
        vstack.axis = .vertical
        vstack.spacing = 4
        vstack.distribution = .fill
        vstack.alignment = .leading
        
        addSubview(vstack)
        vstack.nabla.pinToSuperView()
    }
    
    private func makeRow(with views: UIView...) -> UIView {
        let row = UIStackView(arrangedSubviews: views)
        row.axis = .horizontal
        row.spacing = 4
        row.distribution = .fill
        row.alignment = .center
        return row
    }
    
    private func updateTheme() {
        imageView.tintColor = theme.imageColor
        titleLabel.textColor = theme.titleColor
        titleLabel.font = theme.titleFont
        subtitleLabel.textColor = theme.subtitleColor
        subtitleLabel.font = theme.subtitleFont
        extraLabel.textColor = theme.extraColor
        extraLabel.font = theme.extraFont
    }
    
    private func updateVisibleViews() {
        subtitleLabel.isHidden = subtitle?.nabla.nilIfEmpty == nil
        extraLabel.isHidden = extra?.nabla.nilIfEmpty == nil
        
        secondRow.isHidden = subtitleLabel.isHidden && extraLabel.isHidden
    }
}
