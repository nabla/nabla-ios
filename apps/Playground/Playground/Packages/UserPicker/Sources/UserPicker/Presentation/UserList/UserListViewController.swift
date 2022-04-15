import Foundation
import UIKit

protocol UserListViewControllerDelegate: AnyObject {
    func userListViewController(_ viewController: UserListViewController, didSelect user: User)
}

final class UserListViewController: UIViewController {
    // MARK: - Internal
    
    init(
        delegate: UserListViewControllerDelegate
    ) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
    }
    
    private let repository = UserRepository()
    
    private weak var delegate: UserListViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        return view
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, User> = {
        let dataSource = UITableViewDiffableDataSource<Int, User>(tableView: tableView) { tableView, _, user in
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
                ?? UITableViewCell(style: .subtitle, reuseIdentifier: Constants.cellIdentifier)
            cell.textLabel?.text = user.label
            cell.detailTextLabel?.text = user.uuid.uuidString
            return cell
        }
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        loadData()
    }
    
    private func setUpSubviews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func loadData() {
        let users = repository.getUsers()
        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()
        snapshot.appendSections([0])
        snapshot.appendItems(users, toSection: 0)
        dataSource.apply(snapshot)
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = dataSource.itemIdentifier(for: indexPath) else { return }
        delegate?.userListViewController(self, didSelect: user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
