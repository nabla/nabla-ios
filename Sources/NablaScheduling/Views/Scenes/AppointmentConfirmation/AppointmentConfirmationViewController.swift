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
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.title = ""
        view.subtitle = ""
        view.caption = ""
        return view
    }()
    
    private lazy var consultationDisclaimerCheckboxField = makeCheckboxFieldView(label: L10n.confirmationScreenConsultationDisclaimer) { [viewModel] in
        viewModel.agreesWithConsultationDisclaimer = !viewModel.agreesWithConsultationDisclaimer
    }
    
    private lazy var dataDisclaimerCheckBoxField = makeCheckboxFieldView(label: L10n.confirmationScreenDataDisclaimer) { [viewModel] in
        viewModel.agreesWithPersonalDataDisclaimer = !viewModel.agreesWithPersonalDataDisclaimer
    }
    
    private func makeCheckboxFieldView(label: String, onTap: @escaping () -> Void) -> CheckboxFieldView {
        let view = CheckboxFieldView()
        view.isChecked = false
        view.text = label
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
        view.title = L10n.confirmationScreenActionButtonLabel
        view.theme = NablaTheme.AppointmentConfirmationTheme.button
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
                consultationDisclaimerCheckboxField,
                dataDisclaimerCheckBoxField,
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
            
            if viewModel.appointmentDate.nabla.isToday {
                self.headerView.caption = L10n.confirmationScreenCaptionFormatToday(self.formatTime(date: viewModel.appointmentDate))
            } else {
                self.headerView.caption = L10n.confirmationScreenCaptionFormat(self.formatTimeAndDate(date: viewModel.appointmentDate))
            }
            
            self.consultationDisclaimerCheckboxField.isChecked = viewModel.agreesWithConsultationDisclaimer
            self.dataDisclaimerCheckBoxField.isChecked = viewModel.agreesWithPersonalDataDisclaimer
            self.actionButton.isEnabled = viewModel.canConfirm
            self.actionButton.isLoading = viewModel.isConfirming
            self.updateError()
        }
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
    
    private func updateError() {
        guard presentedViewController == nil, let error = viewModel.error else { return }
        let controller = nabla.makeController(for: error)
        present(controller, animated: true) { [viewModel] in
            viewModel.error = nil
        }
    }
    
    private func formatTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func formatTimeAndDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
