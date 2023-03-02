import Foundation
import NablaCore

// sourcery: AutoMockable
protocol SuccessViewModel: ViewModel {
    func userDidTapActionButton()
}

protocol SuccessViewModelDelegate: AnyObject {
    func successViewModel(_ viewModel: SuccessViewModel, didConfirm appointment: Appointment)
}

final class SuccessViewModelImpl: SuccessViewModel, ObservableObject {
    // MARK: - Internal
    
    weak var delegate: SuccessViewModelDelegate?
    
    func userDidTapActionButton() {
        delegate?.successViewModel(self, didConfirm: appointment)
    }
    
    // MARK: Init
    
    init(
        appointment: Appointment,
        delegate: SuccessViewModelDelegate
    ) {
        self.appointment = appointment
        self.delegate = delegate
    }
    
    // MARK: - Private
    
    private let appointment: Appointment
}
