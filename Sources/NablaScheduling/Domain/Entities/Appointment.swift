import Foundation

public struct Appointment {
    public let id: UUID
    public let state: State
    public let start: Date
    public let provider: Provider
    public let location: Location
    public let price: Price?
    
    public enum State: Equatable {
        case pending(paymentRequirement: PaymentRequirement?)
        case scheduled
        case finalized
    }
    
    public struct PaymentRequirement: Equatable {
        public let price: Price
    }
}
