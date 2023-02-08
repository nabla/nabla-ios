import Combine
import Foundation
import NablaCore

protocol TimeSlotPickerViewModelDelegate: AnyObject {
    func timeSlotPickerViewModel(_ viewModel: TimeSlotPickerViewModel, didSelect: AvailabilitySlot)
}

struct TimeSlotGroupViewItem: Identifiable, Hashable {
    let id: Date
    let title: String
    let subtitle: String
    
    var timeSlots: [TimeSlotViewItem]
    var opened: Bool
}

struct TimeSlotViewItem: Identifiable, Hashable {
    var id: Date { date }
    let date: Date
    
    var selected: Bool
}

// sourcery: AutoMockable
protocol TimeSlotPickerViewModel: ViewModel {
    @MainActor var isLoading: Bool { get }
    @MainActor var groups: [TimeSlotGroupViewItem] { get }
    @MainActor var canContinue: Bool { get }
    @MainActor var error: AlertViewModel? { get set }
    
    @MainActor func userDidPullToRefresh()
    @MainActor func userDidReachEndOfList()
    @MainActor func userDidTapGroup(_ group: TimeSlotGroupViewItem, at index: Int)
    @MainActor func userDidTapTimeSlot(_ timeSlot: TimeSlotViewItem, at timeSlotIndex: Int, in group: TimeSlotGroupViewItem, at groupIndex: Int)
    @MainActor func userDidTapConfirmButton()
}

@MainActor
final class TimeSlotPickerViewModelImpl: TimeSlotPickerViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: TimeSlotPickerViewModelDelegate?
    
    @Published private(set) var isLoading = false
    @Published var error: AlertViewModel?
    
    var groups: [TimeSlotGroupViewItem] {
        Self.transform(slots, openedGroups: openedGroups, selected: selected)
    }
    
    var canContinue: Bool {
        selected != nil
    }
    
    func userDidPullToRefresh() {
        watchAvailabilitySlots()
    }
    
    func userDidReachEndOfList() {
        Task {
            await loadMoreAvailabilitySlots()
        }
    }
    
    func userDidTapGroup(_ group: TimeSlotGroupViewItem, at _: Int) {
        if openedGroups.contains(group.id) {
            openedGroups.remove(group.id)
        } else {
            openedGroups.insert(group.id)
        }
    }
    
    func userDidTapTimeSlot(_ item: TimeSlotViewItem, at itemIndex: Int, in group: TimeSlotGroupViewItem, at _: Int) {
        guard
            let slots = slots[group.id],
            let slot = slots.nabla.element(at: itemIndex),
            slot.start == item.date
        else { return }
        if slot == selected {
            selected = nil
        } else {
            selected = slot
        }
    }
    
    func userDidTapConfirmButton() {
        guard let selected = selected else { return }
        delegate?.timeSlotPickerViewModel(self, didSelect: selected)
    }
    
    // MARK: Init
    
    nonisolated init(
        location: LocationType,
        category: Category,
        client: NablaSchedulingClient,
        delegate: TimeSlotPickerViewModelDelegate
    ) {
        self.location = location
        self.category = category
        self.client = client
        self.delegate = delegate
        
        Task {
            await watchAvailabilitySlots()
        }
    }
    
    // MARK: - Private
    
    private let location: LocationType
    private let category: Category
    private let client: NablaSchedulingClient
    
    @Published private var slots: [Date: [AvailabilitySlot]] = [:]
    @Published private var openedGroups = Set<Date>()
    @Published private var selected: AvailabilitySlot?
    
    private var isLoadingMore = false
    private var loadMore: (() async throws -> Void)?
    private var modelWatcher: AnyCancellable?
    
    private struct TimeSlotGroup {
        let id: UUID
        let title: String
        let subtitle: String
        let dates: [Date]
    }
    
    private func watchAvailabilitySlots() {
        isLoading = true
        
        modelWatcher = client.watchAvailabilitySlots(forCategoryWithId: category.id, location: location)
            .nabla.drive(
                receiveValue: { [weak self] list in
                    self?.slots = Self.group(list.elements)
                    self?.loadMore = list.loadMore
                    self?.isLoading = false
                },
                receiveError: { [weak self] error in
                    self?.error = .error(
                        title: L10n.timeSlotsPickerScreenErrorTitle,
                        error: error,
                        fallbackMessage: L10n.timeSlotsPickerScreenErrorMessage
                    )
                    self?.isLoading = false
                }
            )
    }
    
    private func loadMoreAvailabilitySlots() async {
        guard !isLoadingMore, let loadMore = loadMore else { return }
        isLoadingMore = true
        
        do {
            try await loadMore()
        } catch {
            self.error = .error(
                title: L10n.timeSlotsPickerScreenErrorTitle,
                error: error,
                fallbackMessage: L10n.timeSlotsPickerScreenErrorMessage
            )
        }
        isLoadingMore = false
    }
    
    private static func group(_ slots: [AvailabilitySlot]) -> [Date: [AvailabilitySlot]] {
        .init(grouping: slots) { Calendar.current.startOfDay(for: $0.start) }
    }
    
    private static func transform(
        _ slots: [Date: [AvailabilitySlot]],
        openedGroups: Set<Date>,
        selected: AvailabilitySlot?
    ) -> [TimeSlotGroupViewItem] {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        dateFormatter.doesRelativeDateFormatting = true
        
        return slots
            .nabla.sortedByKeys()
            .map { date, slots -> TimeSlotGroupViewItem in
                TimeSlotGroupViewItem(
                    id: date,
                    title: dateFormatter.string(from: date).capitalized,
                    subtitle: L10n.timeSlotsPickerScreenGroupSubtitleFormat(slots.count),
                    timeSlots: slots.map { transform($0, selected: selected) },
                    opened: openedGroups.contains(date)
                )
            }
    }
    
    private static func transform(_ slot: AvailabilitySlot, selected: AvailabilitySlot?) -> TimeSlotViewItem {
        TimeSlotViewItem(
            date: slot.start,
            selected: slot == selected
        )
    }
}
