import Foundation

struct AvailabilitySlot: Equatable {
    let start: Date
    let end: Date
    let providerId: UUID
    let location: Location
}
