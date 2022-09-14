import Combine
import Foundation
import NablaCore

protocol CategoryPickerViewModelDelegate: AnyObject {
    func categoryPickerViewModel(_ viewModel: CategoryPickerViewModel, didSelect: Category)
}

struct CategoryViewItem {
    let id: UUID
    let title: String
}

// sourcery: AutoMockable
protocol CategoryPickerViewModel: ViewModel {
    var isLoading: Bool { get }
    var items: [CategoryViewItem] { get }
    var error: AlertViewModel? { get set }
    
    func userDidPullToRefresh()
    func userDidSelect(category: CategoryViewItem, at index: Int)
}

final class CategoryPickerViewModelImpl: CategoryPickerViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: CategoryPickerViewModelDelegate?
    
    @Published private(set) var isLoading: Bool = false
    @Published var error: AlertViewModel?
    
    var items: [CategoryViewItem] {
        categories.map(Self.transform(_:))
    }
    
    func userDidPullToRefresh() {
        watchCategories()
    }
    
    func userDidSelect(category item: CategoryViewItem, at index: Int) {
        guard let category = categories.nabla.element(at: index), category.id == item.id else { return }
        delegate?.categoryPickerViewModel(self, didSelect: category)
    }
    
    // MARK: Init
    
    init(
        client: NablaSchedulingClient,
        delegate: CategoryPickerViewModelDelegate
    ) {
        self.client = client
        self.delegate = delegate
        watchCategories()
    }
    
    // MARK: - Private
    
    private let client: NablaSchedulingClient
    
    private var categoriesWatcher: AnyCancellable?
    
    @Published private var categories: [Category] = []
    
    private func watchCategories() {
        isLoading = true
        
        categoriesWatcher = client.watchCategories()
            .nabla.drive(
                receiveValue: { [weak self] categories in
                    self?.categories = categories
                    self?.isLoading = false
                },
                receiveError: { [weak self] error in
                    self?.error = .error(
                        title: L10n.categoryPickerScreenErrorTitle,
                        error: error,
                        fallbackMessage: L10n.categoryPickerScreenErrorMessage
                    )
                    self?.isLoading = false
                }
            )
    }
    
    private static func transform(_ category: Category) -> CategoryViewItem {
        CategoryViewItem(
            id: category.id,
            title: category.name
        )
    }
}
