import Foundation
import NablaCore
import UIKit

protocol LocationPickerViewModelDelegate: AnyObject {
    func locationPickerViewModel(_ viewModel: LocationPickerViewModel, didSkipStepWithSingleLocation location: LocationType)
    func locationPickerViewModel(_ viewModel: LocationPickerViewModel, didSelect location: LocationType)
}

struct LocationViewItem {
    let id: LocationType
    let icon: UIImage
    let name: String
}

// sourcery: AutoMockable
protocol LocationPickerViewModel: ViewModel {
    @MainActor var isLoading: Bool { get }
    @MainActor var items: [LocationViewItem] { get }
    @MainActor var error: AlertViewModel? { get set }
    
    @MainActor func start()
    @MainActor func userDidPullToRefresh()
    @MainActor func userDidSelect(location: LocationViewItem, at index: Int)
}

@MainActor
final class LocationPickerViewModelImpl: LocationPickerViewModel, ObservableObject {
    // MARK: - Internal
    
    struct Dependencies {
        let client: NablaSchedulingClient
    }
    
    weak var delegate: LocationPickerViewModelDelegate?
    
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var items: [LocationViewItem] = []
    @Published var error: AlertViewModel?
    
    func start() {
        Task {
            await loadAvailableLocations()
        }
    }
    
    func userDidPullToRefresh() {
        Task {
            await loadAvailableLocations()
        }
    }
    
    func userDidSelect(location: LocationViewItem, at _: Int) {
        delegate?.locationPickerViewModel(self, didSelect: location.id)
    }
    
    // MARK: Init
    
    nonisolated init(
        delegate: LocationPickerViewModelDelegate,
        client: NablaSchedulingClient
    ) {
        self.delegate = delegate
        self.client = client
    }
    
    // MARK: - Private
    
    private let client: NablaSchedulingClient
    
    private func loadAvailableLocations() async {
        isLoading = true
        do {
            let availableLocations = try await client.getAvailableLocations()
            if let location = availableLocations.first, availableLocations.count == 1 {
                delegate?.locationPickerViewModel(self, didSkipStepWithSingleLocation: location)
            }
            items = availableLocations
                .map(adapt(location:))
                .nabla.sorted(\.name)
        } catch {
            self.error = .error(
                title: L10n.locationPickerScreenErrorTitle,
                error: error,
                fallbackMessage: L10n.locationPickerScreenErrorMessage
            )
        }
        isLoading = false
    }
    
    private nonisolated func adapt(location: LocationType) -> LocationViewItem {
        switch location {
        case .remote:
            return .init(
                id: .remote,
                icon: .nabla.symbol(.video),
                name: L10n.locationPickerRemoteLocationName
            )
        case .physical:
            return .init(
                id: .physical,
                icon: .nabla.symbol(.house),
                name: L10n.locationPickerPhysicalLocationName
            )
        }
    }
}
