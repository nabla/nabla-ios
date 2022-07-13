import Foundation
import UIKit

public class ConversationListView: UIView, ConversationListViewContract {
    // MARK: - Public
    
    var presenter: ConversationListPresenter?
    
    // MARK: - Initializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil {
            presenter?.start()
        }
    }
    
    // MARK: - ConversationListViewContract
    
    func configure(with state: ConversationListViewState) {
        switch state {
        case let .loaded(viewModel):
            let animated = !self.viewModel.items.isEmpty
            self.viewModel = viewModel
            tableView.reload(animated: animated)
            loadingIndicator.isHidden = true
            errorView.isHidden = true
            tableView.isHidden = false
        case let .error(errorViewModel):
            errorView.configure(with: errorViewModel)
            loadingIndicator.isHidden = true
            errorView.isHidden = false
            tableView.isHidden = true
        case .loading:
            loadingIndicator.isHidden = false
            errorView.isHidden = true
            tableView.isHidden = true
        }
    }
    
    func displayLoadingMore() {
        tableView.tableFooterView = loadingFooterView
        let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height)
        tableView.setContentOffset(bottomOffset, animated: true)
    }
    
    func hideLoadingMore() {
        tableView.tableFooterView = nil
    }
    
    // MARK: - Private
    
    private lazy var tableView: UITableView = createTableView()
    private lazy var loadingIndicator: UIActivityIndicatorView = createLoadingIndicator()
    private lazy var errorView: ErrorView = createErrorView()
    private lazy var loadingFooterView: LoadingFooterView = createLoadingFooterView()
    
    private var viewModel: ConversationListViewModel = .empty
    
    private func setUp() {
        backgroundColor = NablaTheme.ConversationPreview.backgroundColor
        addSubview(tableView)
        tableView.pinToSuperView()
        addSubview(loadingIndicator)
        loadingIndicator.centerInSuperView()
        addSubview(errorView)
        errorView.pinToSuperView()
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ConversationListItemCell.self)
        tableView.separatorInset = .only(left: 70)
        tableView.backgroundColor = NablaTheme.ConversationPreview.backgroundColor
        return tableView
    }
    
    private func createLoadingIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    private func createErrorView() -> ErrorView {
        let view = ErrorView()
        view.delegate = self
        return view
    }
    
    private func createLoadingFooterView() -> LoadingFooterView {
        let footerView = LoadingFooterView()
        footerView.sizeToFit()
        return footerView
    }
}

extension ConversationListView: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: ConversationListItemCell.self, for: indexPath)
        cell.configure(with: viewModel.items[indexPath.row])
        return cell
    }
}

extension ConversationListView: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Notify presenter
        presenter?.didSelectConversation(at: indexPath)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height * 0.9 {
            presenter?.didScrollToBottom()
        }
    }
}

extension ConversationListView: ErrorViewDelegate {
    // MARK: - ErrorViewDelegate
    
    func errorViewDidTapButton(_: ErrorView) {
        presenter?.didTapRetry()
    }
}
