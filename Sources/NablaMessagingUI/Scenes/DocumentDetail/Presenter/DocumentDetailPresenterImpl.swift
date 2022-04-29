import Foundation
import NablaMessagingCore

class DocumentDetailPresenterImpl: DocumentDetailPresenter {
    // MARK: - Initializer
    
    init(viewContract: DocumentDetailViewContract, document: Media) {
        self.viewContract = viewContract
        self.document = document
    }
    
    // MARK: - Presenter
    
    func start() {
        let mapper = DocumentDetailViewModelMapper()
        let viewModel = mapper.map(document: document)
        viewContract?.configure(with: viewModel)
    }
    
    // MARK: - DocumentDetailPresenter
    
    // MARK: - Private
    
    private weak var viewContract: DocumentDetailViewContract?
    private let document: Media
}
