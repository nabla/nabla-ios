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
    @MainActor var isLoading: Bool { get }
    @MainActor var disclaimer: String? { get }
    @MainActor var items: [CategoryViewItem] { get }
    @MainActor var error: AlertViewModel? { get set }
    
    @MainActor func userDidPullToRefresh()
    @MainActor func userDidSelect(category: CategoryViewItem, at index: Int)
}

@MainActor
final class CategoryPickerViewModelImpl: CategoryPickerViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: CategoryPickerViewModelDelegate?
    
    @Published private(set) var isLoading: Bool = false
    @Published var error: AlertViewModel?
    
    var disclaimer: String? {
        switch preselectedLocation {
        case .none: return nil
        case .remote: return L10n.categoryPickerScreenRemoteLocationDisclaimer
        case .physical: return L10n.categoryPickerScreenPhysicalLocationDisclaimer
        }
    }
    
    var items: [CategoryViewItem] {
        categories.map { transform($0) }
    }
    
    func userDidPullToRefresh() {
        watchCategories()
    }
    
    func userDidSelect(category item: CategoryViewItem, at index: Int) {
        guard let category = categories.nabla.element(at: index), category.id == item.id else { return }
        delegate?.categoryPickerViewModel(self, didSelect: category)
    }
    
    // MARK: Init
    
    nonisolated init(
        preselectedLocation: LocationType?,
        client: NablaSchedulingClient,
        delegate: CategoryPickerViewModelDelegate
    ) {
        self.preselectedLocation = preselectedLocation
        self.client = client
        self.delegate = delegate
        
        Task {
            await watchCategories()
        }
    }
    
    // MARK: - Private
    
    private let preselectedLocation: LocationType?
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
    
    private func transform(_ category: Category) -> CategoryViewItem {
        CategoryViewItem(
            id: category.id,
            title: category.name
        )
    }
}
