enum RemoteAppointmentTransformer {
    // MARK: - Internal
    
    static func transform(_ remote: RemoteAppointment) -> Appointment {
        let (state, videoCallRoom) = transform(remote.state)
        return Appointment(
            id: remote.id,
            state: state,
            start: remote.scheduledAt,
            provider: RemoteProviderTransformer.transform(remote.provider.fragments.providerFragment),
            videoCallRoom: videoCallRoom
        )
    }
    
    static func transform(_ state: RemoteAppointment.State) -> (Appointment.State, Appointment.VideoCallRoom?) {
        if let upcoming = state.asUpcomingAppointment {
            let room = transform(upcoming.fragments.upcomingAppointmentFragment)
            return (.upcoming, room)
        }
        return (.finalized, nil)
    }
    
    static func transform(_ state: Appointment.State) -> RemoteAppointment.State.Enum {
        switch state {
        case .upcoming: return .upcoming
        case .finalized: return .finalized
        }
    }
                    
    // MARK: - Private
            
    private static func transform(_ upcoming: GQL.UpcomingAppointmentFragment) -> Appointment.VideoCallRoom? {
        guard let openStatus = upcoming.livekitRoom?.fragments.livekitRoomFragment.status.asLivekitRoomOpenStatus?.fragments.livekitRoomOpenStatusFragment else { return nil }
        return Appointment.VideoCallRoom(url: openStatus.url, token: openStatus.token)
    }
}
