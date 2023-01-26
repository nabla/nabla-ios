import Combine
import NablaCore
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

@MainActor class LocationPickerViewControllerTests: XCTestCase {
    private var sut: LocationPickerViewController!
    
    private var viewModel: LocationPickerViewModelMock!
    private var navigationController: UINavigationController!

    override func setUp() {
        super.setUp()
        viewModel = .init()
        sut = LocationPickerViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: sut)
        navigationController.navigationBar.prefersLargeTitles = true
        
        viewModel.given(.onChange(willReturn: Just(()).eraseToAnyPublisher()))
        viewModel.given(.onChange(throttle: .any, willReturn: Just(()).eraseToAnyPublisher()))
    }

    func testLocationPickerViewControllerWithItems() {
        // GIVEN
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.items(getter: [
            .init(id: .physical, icon: .nabla.symbol(.house), name: "Physical"),
            .init(id: .remote, icon: .nabla.symbol(.video), name: "Remote"),
        ]))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testLocationPickerViewControllerEmptyView() {
        // GIVEN
        viewModel.given(.isLoading(getter: false))
        viewModel.given(.items(getter: []))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testLocationPickerViewControllerLoading() {
        // GIVEN
        viewModel.given(.isLoading(getter: true))
        viewModel.given(.items(getter: []))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages(wait: 0.5))
    }
}
