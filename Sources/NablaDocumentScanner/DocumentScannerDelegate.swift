import Foundation
import PDFKit

public protocol DocumentScannerDelegate: AnyObject {
    func documentScanner(_ scannerViewController: UIViewController, didScan pdfDocument: PDFDocument)
}
