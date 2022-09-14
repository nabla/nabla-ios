import Foundation

enum RemoteAvailabilitySlotsTransformer {
    static func transform(_ remoteAvailabilitySlot: RemoteAvailabilitySlot) -> AvailabilitySlot {
        AvailabilitySlot(
            start: remoteAvailabilitySlot.startAt,
            end: remoteAvailabilitySlot.endAt,
            providerId: remoteAvailabilitySlot.provider.id
        )
    }
}
