import Foundation

enum RemoteAvailabilitySlotsTransformer {
    // MARK: - Internal
    
    static func transform(_ remoteAvailabilitySlot: RemoteAvailabilitySlot) -> AvailabilitySlot {
        AvailabilitySlot(
            start: remoteAvailabilitySlot.startAt,
            end: remoteAvailabilitySlot.endAt,
            providerId: remoteAvailabilitySlot.provider.id,
            location: transform(remoteAvailabilitySlot.location)
        )
    }
    
    // MARK: - Private
    
    private static func transform(_ location: RemoteAvailabilitySlot.Location) -> Location {
        if let physicalLocation = location.asPhysicalAvailabilitySlotLocation {
            let address = physicalLocation.address.fragments.addressFragment
            return .physical(.init(address: .init(
                id: address.id,
                address: address.address,
                zipCode: address.zipCode,
                city: address.city,
                state: address.state,
                country: address.country,
                extraDetails: address.extraDetails
            )))
        } else if location.asRemoteAvailabilitySlotLocation != nil {
            return .remote(.undefined)
        } else {
            assertionFailure("Unknown location type")
            return .unknown
        }
    }
}
