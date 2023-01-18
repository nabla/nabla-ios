import Foundation

public struct Appointment {
    public let id: UUID
    public let state: State
    public let start: Date
    public let provider: Provider
    public let location: Location
    
    public enum State {
        case upcoming
        case finalized
    }
}
