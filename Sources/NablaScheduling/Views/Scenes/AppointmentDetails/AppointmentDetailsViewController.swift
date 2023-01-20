import Foundation
import NablaCore
import UIKit

final class AppointmentDetailsViewController: UIViewController {
    // MARK: - Internal
    
    // MARK: Init
    
    init(
        viewModel: AppointmentDetailsViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = L10n.appointmentDetailsScreenTitle
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    @ObservedViewModel private var viewModel: AppointmentDetailsViewModel
    
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
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = NablaTheme.Shared.loadingViewIndicatorTintColor
        view.startAnimating()
        return view
    }()
    
    private lazy var headerView: AppointmentDetailsView = {
        let view = AppointmentDetailsView(
            frame: .zero,
            theme: NablaTheme.AppointmentDetailsTheme.header
        )
        view.title = ""
        view.subtitle = ""
        view.caption = ""
        view.onDetailsTapped = { [viewModel] in
            viewModel.userDidTapAppointmentDetails()
        }
        return view
    }()
    
    private lazy var scrollableContainer: ScrollableContainerView = .init(alignment: .top)
    
    private lazy var bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var actionButton: NablaViews.PrimaryButton = {
        let view = NablaViews.PrimaryButton()
        view.setTitle(L10n.appointmentDetailsScreenActionButtonLabel, for: .normal)
        view.theme = NablaTheme.AppointmentDetailsTheme.cancelButton
        view.onTap = { [viewModel] in
            viewModel.userDidTapCancelButton()
        }
        return view
    }()
    
    private func setUp() {
        view.backgroundColor = NablaTheme.AppointmentDetailsTheme.backgroundColor
        
        let vstack = UIStackView(
            arrangedSubviews: [
                headerView,
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
        
        view.addSubview(loadingView)
        loadingView.nabla.constraintToCenterInSuperView()
    }
    
    // MARK: ViewModel
    
    private func observeViewModel() {
        _viewModel.onChange { [weak self] viewModel in
            guard let self = self else { return }
            self.updateModal()
            switch viewModel.state {
            case .loading:
                self.loadingView.isHidden = false
                self.scrollableContainer.isHidden = true
            case let .ready(viewModel):
                self.loadingView.isHidden = true
                self.scrollableContainer.isHidden = false
                self.updateDetails(viewModel)
                self.update(provider: viewModel.provider)
            }
        }
    }
    
    private func updateDetails(_ viewModel: AppointmentsDetailsViewItem) {
        headerView.caption = viewModel.caption
        headerView.captionIcon = viewModel.captionIcon
        headerView.details1 = viewModel.details1
        headerView.details2 = viewModel.details2
        bottomContainer.isHidden = !viewModel.showCancelButton
    }
    
    private func update(provider: Provider) {
        headerView.avatar = .init(
            url: provider.avatarUrl?.absoluteString,
            text: ProviderNameComponentsFormatter(style: .initials).string(from: .init(provider))
        )
                   
        headerView.title = ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(provider))
        headerView.subtitle = provider.title
    }
    
    private func updateModal() {
        guard presentedViewController == nil, let modal = viewModel.modal else { return }
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
