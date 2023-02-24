import Combine
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

@MainActor class SuccessViewControllerTests: XCTestCase {
    private var sut: SuccessViewController!
    
    private var viewModel: SuccessViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
        
        sut = .init(viewModel: viewModel)
    }
    
    func testStandalone() {
        // GIVEN
        // WHEN
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages())
    }
    
    func testWithNavigationController() {
        // GIVEN
        // WHEN
        let navigationController = UINavigationController(rootViewController: sut)
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
}
