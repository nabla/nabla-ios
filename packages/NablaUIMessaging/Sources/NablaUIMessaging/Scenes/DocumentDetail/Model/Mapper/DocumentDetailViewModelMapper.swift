import Foundation
import NablaCore

struct DocumentDetailViewModelMapper {
    // MARK: - Public
    
    func map(document: Media) -> DocumentDetailViewModel {
        DocumentDetailViewModel(url: document.fileUrl)
    }
}
