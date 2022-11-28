import Combine
import Foundation
import NablaCore

struct CurrentVideoCallContext {
    let token: String
    let reopen: () -> Void
}

final class CurrentVideoCallInteractor {
    // MARK: - Internal
    
    var currentVideoCallToken: String? {
        currentVideoCallContext.value?.token
    }
    
    func watchCurrentVideoCall() -> AnyPublisher<String?, Never> {
        currentVideoCallContext
            .map { $0?.token }
            .eraseToAnyPublisher()
    }
    
    func openCurrentVideoCall() {
        currentVideoCallContext.value?.reopen()
    }
    
    func becomeCurrentVideoCall(token: String, reopen: @escaping () -> Void) {
        let context = CurrentVideoCallContext(token: token, reopen: reopen)
        currentVideoCallContext.send(context)
    }
    
    func resignCurrentVideoCall() {
        currentVideoCallContext.send(nil)
    }
    
    // MARK: - Private
    
    private let currentVideoCallContext = CurrentValueSubject<CurrentVideoCallContext?, Never>(nil)
}
