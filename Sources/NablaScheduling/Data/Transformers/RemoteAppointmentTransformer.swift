import Foundation
import NablaCore

final class RemoteAppointmentTransformer {
    // MARK: - Internal
    
    func transform(_ remote: RemoteAppointment) -> Appointment {
        Appointment(
            id: remote.id,
            state: transform(remote.state),
            start: remote.scheduledAt,
            provider: RemoteProviderTransformer.transform(remote.provider.fragments.providerFragment),
            location: transform(remote.location)
        )
    }
    
    func transform(_ state: Appointment.State) -> RemoteAppointment.State.Enum {
        switch state {
        case .upcoming: return .upcoming
        case .finalized: return .finalized
        }
    }
    
    // MARK: Init
    
    init(logger: Logger) {
        self.logger = logger
    }
                    
    // MARK: - Private
    
    private let logger: Logger
            
    private func transform(_ location: RemoteAppointment.Location) -> Location {
        if let remoteLocation = location.fragments.locationFragment.asRemoteAppointmentLocation {
            return .remote(
                remoteLocation.externalCallUrl.flatMap { URL(string: $0) }.map { .externalCallURL($0) }
                    ?? remoteLocation.livekitRoom.flatMap { transform($0.fragments.livekitRoomFragment) }.map { .videoCallRoom($0) }
                    ?? .undefined
            )
        } else if let physicalLocation = location.fragments.locationFragment.asPhysicalAppointmentLocation {
            let address = transform(physicalLocation.address.fragments.addressFragment)
            return .physical(.init(address: address))
        }
        let message = "Unknown appointment location"
        logger.error(message: message)
        assertionFailure(message)
        return .unknown
    }
    
    private func transform(_ state: RemoteAppointment.State) -> Appointment.State {
        if state.asUpcomingAppointment != nil {
            return .upcoming
        } else if state.asFinalizedAppointment != nil {
            return .finalized
        }
        let message = "Unknown appointment state"
        logger.error(message: message)
        assertionFailure(message)
        return .finalized
    }
    
    private func transform(_ address: GQL.AddressFragment) -> Address {
        .init(
            id: address.id,
            address: address.address,
            zipCode: address.zipCode,
            city: address.city,
            state: address.state,
            country: address.country,
            extraDetails: address.extraDetails
        )
    }
    
    private func transform(_ livekitRoom: GQL.LivekitRoomFragment) -> Location.RemoteLocation.VideoCallRoom? {
        guard let openStatus = livekitRoom.status.asLivekitRoomOpenStatus?.fragments.livekitRoomOpenStatusFragment else { return nil }
        return .init(url: openStatus.url, token: openStatus.token)
    }
}
