typealias RemoteAppointment = GQL.AppointmentFragment

extension RemoteAppointment.State {
    enum Enum {
        case upcoming
        case finalized
    }
    
    var asEnum: Enum {
        if asUpcomingAppointment != nil {
            return .upcoming
        } else {
            return .finalized
        }
    }
}
