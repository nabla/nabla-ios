import Combine
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class TimeSlotPickerViewControllerTests: XCTestCase {
    private var sut: TimeSlotPickerViewController!
    
    private var viewModel: TimeSlotPickerViewModelMock!
    private var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
        
        sut = TimeSlotPickerViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: sut)
        
        viewModel.given(.onChange(willReturn: Just(()).eraseToAnyPublisher()))
        viewModel.given(.onChange(throttle: .any, willReturn: Just(()).eraseToAnyPublisher()))
    }

    func testTimeSlotPickerViewControllerDefault() {
        // GIVEN
        let data = makeGroups(openedGroups: [], selectedSlot: nil)
        viewModel.given(.groups(getter: data))
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.canContinue(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testTimeSlotPickerViewControllerEmptyView() {
        // GIVEN
        viewModel.given(.groups(getter: []))
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.canContinue(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testTimeSlotPickerViewControllerLoading() {
        // GIVEN
        viewModel.given(.groups(getter: []))
        viewModel.given(.isLoading(getter: true))
        viewModel.given(.canContinue(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testTimeSlotPickerViewControllerLoadingWithIems() {
        // GIVEN
        let data = makeGroups(openedGroups: [], selectedSlot: nil)
        viewModel.given(.groups(getter: data))
        viewModel.given(.isLoading(getter: true))
        viewModel.given(.canContinue(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testTimeSlotPickerViewControllerOneGroupOpened() {
        // GIVEN
        let data = makeGroups(openedGroups: [4], selectedSlot: nil)
        viewModel.given(.groups(getter: data))
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.canContinue(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testTimeSlotPickerViewControllerTwoGroupsOpened() {
        // GIVEN
        let data = makeGroups(openedGroups: [3, 7], selectedSlot: nil)
        viewModel.given(.groups(getter: data))
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.canContinue(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testTimeSlotPickerViewControllerSelected() {
        // GIVEN
        let data = makeGroups(openedGroups: [4], selectedSlot: IndexPath(item: 2, section: 4))
        viewModel.given(.groups(getter: data))
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.canContinue(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    private func makeGroups(openedGroups: Set<Int>, selectedSlot: IndexPath?) -> [TimeSlotGroupViewItem] {
        (0 ... 10).map { groupIndex in
            .init(
                id: .init(),
                title: "Title \(groupIndex)",
                subtitle: "Subtitle",
                timeSlots: (0 ... 3).map { slotIndex in
                    .init(
                        date: Date(timeIntervalSince1970: TimeInterval(slotIndex) * 30 * 60),
                        selected: IndexPath(item: slotIndex, section: groupIndex) == selectedSlot
                    )
                },
                opened: openedGroups.contains(groupIndex)
            )
        }
    }
}
