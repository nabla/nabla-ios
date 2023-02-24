// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GQL.Unions {
  static let AppointmentState = Union(
    name: "AppointmentState",
    possibleTypes: [
      GQL.Objects.PendingAppointment.self,
      GQL.Objects.UpcomingAppointment.self,
      GQL.Objects.FinalizedAppointment.self
    ]
  )
}