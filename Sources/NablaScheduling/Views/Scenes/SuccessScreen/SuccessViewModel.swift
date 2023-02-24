import Foundation
import NablaCore

// sourcery: AutoMockable
protocol SuccessViewModel: ViewModel {
    func userDidTapActionButton()
}

protocol SuccessViewModelDelegate: AnyObject {
    func successViewModelDidConfirm(_ viewModel: SuccessViewModel)
}

final class SuccessViewModelImpl: SuccessViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: SuccessViewModelDelegate?
    
    func userDidTapActionButton() {
        delegate?.successViewModelDidConfirm(self)
    }
    
    // MARK: Init
    
    init(delegate: SuccessViewModelDelegate) {
        self.delegate = delegate
    }
}
