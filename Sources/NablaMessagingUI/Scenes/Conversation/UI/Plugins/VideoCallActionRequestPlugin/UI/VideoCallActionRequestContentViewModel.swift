import Foundation

struct VideoCallActionRequestContentViewModel {
    let state: State
    
    enum State {
        case waiting
        case opened
        case closed
    }
}
