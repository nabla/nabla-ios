import UIKit
import VisionKit

public enum DocumentScannerModule {
    /// ⚠️ Do not change the `modalPresentationStyle` of the returned view controller as it needs to be displayed in fullscreen style.
    public static func makeViewController(delegate: DocumentScannerDelegate) -> UIViewController {
        let viewController = VNDocumentCameraViewController()
        delegateWrapperRetainer = DocumentCameraViewControllerDelegateWrapper(
            wrappedDelegate: delegate,
            onScanDone: { delegateWrapperRetainer = nil }
        )
        viewController.delegate = delegateWrapperRetainer
        return viewController
    }
    
    // This property is mandatory to retain the delegate wrapper as the delegate property is `weak` in `VNDocumentCameraViewController`
    private static var delegateWrapperRetainer: DocumentCameraViewControllerDelegateWrapper?
}
