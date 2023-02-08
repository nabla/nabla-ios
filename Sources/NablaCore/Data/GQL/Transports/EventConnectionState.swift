import Foundation

public enum EventsConnectionState {
    case notConnected
    case disconnected(since: Date)
    case connecting
    case connected
}
