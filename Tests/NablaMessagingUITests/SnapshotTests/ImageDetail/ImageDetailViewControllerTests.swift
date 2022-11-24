import NablaCoreTestsUtils
import NablaMessagingCoreTestsUtils
@testable import NablaMessagingUI
import SnapshotTesting
import XCTest

final class ImageDetailViewControllerTests: XCTestCase {
    private let size = ViewImageConfig.iPhoneX.size
    private var sut: ImageDetailViewController!

    override func setUp() {
        super.setUp()
        
        sut = ImageDetailViewController()
        sut.presenter = ImageDetailPresenterImpl(viewContract: sut, image: .mockWithLocalAsset)
    }
    
    func testImageDetailViewControllerInNavigationController() {
        // Given
        let navigationController = UINavigationController(rootViewController: sut).nabla.withOpaqueNavigationBarBackground()
        // When
        sut.viewWillAppear(true)
        // Then
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages(wait: 1, size: size))
    }
}
