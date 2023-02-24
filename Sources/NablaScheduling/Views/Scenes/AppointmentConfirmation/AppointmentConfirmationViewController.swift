import NablaCore
import UIKit

final class AppointmentConfirmationViewController: UIViewController {
    // MARK: - Internal
    
    // MARK: Init
    
    init(
        viewModel: AppointmentConfirmationViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = L10n.confirmationScreenTitle
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    @ObservedViewModel private var viewModel: AppointmentConfirmationViewModel
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        observeViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollableContainer.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomContainer.frame.height, right: 0)
    }
    
    // MARK: Subviews
    
    private lazy var headerView: AppointmentDetailsView = {
        let view = AppointmentDetailsView(
            frame: .zero,
            theme: NablaTheme.AppointmentConfirmationTheme.header
        )
        view.title = ""
        view.subtitle = ""
        view.onLocationTap = { [weak self] in
            self?.viewModel.userDidTapAppointmentLocation()
        }
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.onRetryButtonTap = { [weak self] in
            self?.viewModel.consentsLoadingError?.handler()
        }
        return view
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = NablaTheme.Shared.loadingViewIndicatorTintColor
        view.startAnimating()
        return view
    }()
    
    private lazy var firstConsentCheckboxField = makeCheckboxFieldView { [viewModel] in
        viewModel.agreesWithFirstConsent = !viewModel.agreesWithFirstConsent
    }
    
    private lazy var secondConsentCheckBoxField = makeCheckboxFieldView { [viewModel] in
        viewModel.agreesWithSecondConsent = !viewModel.agreesWithSecondConsent
    }
    
    private func makeCheckboxFieldView(onTap: @escaping () -> Void) -> CheckboxFieldView {
        let view = CheckboxFieldView()
        view.isChecked = false
        view.onTap = onTap
        return view
    }
    
    private lazy var bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var actionButton: NablaViews.PrimaryButton = {
        let view = NablaViews.PrimaryButton()
        view.theme = NablaTheme.AppointmentConfirmationTheme.confirmButton
        view.onTap = { [viewModel] in
            viewModel.userDidTapConfirmButton()
        }
        return view
    }()
    
    private lazy var scrollableContainer: ScrollableContainerView = .init(alignment: .top)
    
    private func setUp() {
        view.backgroundColor = NablaTheme.AppointmentConfirmationTheme.backgroundColor
        
        let vstack = UIStackView(
            arrangedSubviews: [
                headerView,
                errorView,
                loadingView,
                firstConsentCheckboxField,
                secondConsentCheckBoxField,
            ]
        )
        vstack.axis = .vertical
        vstack.distribution = .fill
        vstack.alignment = .fill
        vstack.spacing = 16
        
        scrollableContainer.contentView.addSubview(vstack)
        vstack.nabla.pinToSuperView(insets: .nabla.all(16))
        
        view.addSubview(scrollableContainer)
        scrollableContainer.nabla.pin(to: view.safeAreaLayoutGuide)
        
        bottomContainer.addSubview(actionButton)
        actionButton.nabla.pinToSuperView(insets: .nabla.all(16))
        
        view.addSubview(bottomContainer)
        bottomContainer.nabla.pin(to: view.safeAreaLayoutGuide, edges: [.leading, .bottom, .trailing])
    }
    
    // MARK: ViewModel
    
    private func observeViewModel() {
        _viewModel.onChange { [weak self] viewModel in
            guard let self = self else { return }
            self.updateProvider()
            self.updateError()
            self.updateDetails()
            
            if viewModel.isLoadingConsents {
                self.actionButton.isHidden = true
                self.firstConsentCheckboxField.isHidden = true
                self.secondConsentCheckBoxField.isHidden = true
                self.errorView.isHidden = true
                self.loadingView.isHidden = false
            } else if let consentsLoadingError = viewModel.consentsLoadingError {
                self.actionButton.isHidden = true
                self.firstConsentCheckboxField.isHidden = true
                self.secondConsentCheckBoxField.isHidden = true
                self.errorView.isHidden = false
                self.loadingView.isHidden = true
                
                self.errorView.text = consentsLoadingError.message
            } else {
                self.errorView.isHidden = true
                self.loadingView.isHidden = true
                
                self.updateConsents(viewModel.consents)
                
                self.actionButton.isHidden = false
                
                self.actionButton.isEnabled = viewModel.canConfirm
                self.actionButton.isLoading = viewModel.isConfirming
            }
        }
    }
    
    private func updateDetails() {
        actionButton.setTitle(viewModel.confirmActionTitle, for: .normal)
        
        headerView.locationType = viewModel.locationType
        headerView.location = viewModel.location
        headerView.locationDetails = viewModel.locationDetails
        headerView.date = viewModel.date
        headerView.price = viewModel.price
    }
    
    private func updateProvider() {
        guard let provider = viewModel.provider else { return }
        headerView.avatar = .init(
            url: provider.avatarUrl?.absoluteString,
            text: ProviderNameComponentsFormatter(style: .initials).string(from: .init(provider))
        )
                   
        headerView.title = ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(provider))
        headerView.subtitle = provider.title
    }
    
    private func updateConsents(_: ConsentsViewModel?) {
        if let consents = viewModel.consents, let firstConsentHtml = consents.firstConsentHtml {
            firstConsentCheckboxField.attributedText = formatAttributedStringForDisplay(firstConsentHtml)
            firstConsentCheckboxField.isChecked = viewModel.agreesWithFirstConsent
            firstConsentCheckboxField.isHidden = false
            firstConsentCheckboxField.enableTapOnTextToCheck = !consents.firstConsentContainsLink
        } else {
            firstConsentCheckboxField.isHidden = true
        }
        
        if let consents = viewModel.consents, let secondConsentHtml = consents.secondConsentHtml {
            secondConsentCheckBoxField.attributedText = formatAttributedStringForDisplay(secondConsentHtml)
            secondConsentCheckBoxField.isChecked = viewModel.agreesWithSecondConsent
            secondConsentCheckBoxField.isHidden = false
            secondConsentCheckBoxField.enableTapOnTextToCheck = !consents.secondConsentContainsLink
        } else {
            secondConsentCheckBoxField.isHidden = true
        }
    }
    
    private func formatAttributedStringForDisplay(_ attributedString: NSAttributedString) -> NSAttributedString {
        let mutableAttributedConsentHtml = NSMutableAttributedString(attributedString: attributedString)
        mutableAttributedConsentHtml.addAttribute(
            .font,
            value: NablaTheme.AppointmentConfirmationTheme.disclaimersFont,
            range: NSMakeRange(0, attributedString.length)
        )
        
        mutableAttributedConsentHtml.addAttribute(
            .foregroundColor,
            value: NablaTheme.AppointmentConfirmationTheme.disclaimersTextColor,
            range: NSMakeRange(0, attributedString.length)
        )
        
        return mutableAttributedConsentHtml
    }
    
    private func updateError() {
        guard let modal = viewModel.modal else { return }
        switch modal {
        case let .alert(alert):
            let controller = nabla.makeController(for: alert)
            present(controller, animated: true) { [viewModel] in
                viewModel.modal = nil
            }
        case let .detailSheet(sheet):
            let controller = nabla.makeController(for: sheet, sourceView: headerView)
            present(controller, animated: true) { [viewModel] in
                viewModel.modal = nil
            }
        }
    }
}
