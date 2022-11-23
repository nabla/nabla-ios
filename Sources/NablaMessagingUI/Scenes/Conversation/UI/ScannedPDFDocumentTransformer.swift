import Foundation
import NablaMessagingCore
import PDFKit

enum ScannedPDFDocumentTransformer {
    static func transform(_ pdfDocument: PDFDocument) -> DocumentFile? {
        guard let data = pdfDocument.dataRepresentation() else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")

        return DocumentFile(
            fileName: L10n.conversationAddMediaScanDocumentFilename(
                formatter.string(from: Date())
            ),
            content: .data(data),
            thumbnail: nil,
            mimeType: .pdf
        )
    }
}
