import Foundation

struct Appointment {
    let id: UUID
    let state: State
    let start: Date
    let provider: Provider
    let videoCallRoom: VideoCallRoom?
    
    enum State {
        case upcoming
        case finalized
    }
    
    struct VideoCallRoom {
        let url: String
        let token: String
    }
}
