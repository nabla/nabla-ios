import Foundation
import PDFKit
import VisionKit

final class DocumentCameraViewControllerDelegateWrapper: NSObject {
    init(
        wrappedDelegate: DocumentScannerDelegate,
        onScanDone: @escaping () -> Void
    ) {
        self.wrappedDelegate = wrappedDelegate
        self.onScanDone = onScanDone
    }
    
    private let wrappedDelegate: DocumentScannerDelegate?
    private let onScanDone: () -> Void
}

extension DocumentCameraViewControllerDelegateWrapper: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(
        _ controller: VNDocumentCameraViewController,
        didFinishWith scan: VNDocumentCameraScan
    ) {
        guard let wrappedDelegate = wrappedDelegate else {
            return
        }
        let pdfDocument = PDFDocument()
        (0 ..< scan.pageCount)
            .compactMap { scan.imageOfPage(at: $0) }
            .compactMap(PDFPage.init)
            .enumerated()
            .forEach { pdfDocument.insert($1, at: $0) }
        
        wrappedDelegate.documentScanner(controller, didScan: pdfDocument)
        onScanDone()
    }
    
    func documentCameraViewControllerDidCancel(_: VNDocumentCameraViewController) {
        onScanDone()
    }
    
    func documentCameraViewController(_: VNDocumentCameraViewController, didFailWithError _: Error) {
        onScanDone()
    }
}
