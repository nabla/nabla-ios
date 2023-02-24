// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GQL.Unions {
  static let AppointmentLocation = Union(
    name: "AppointmentLocation",
    possibleTypes: [
      GQL.Objects.PhysicalAppointmentLocation.self,
      GQL.Objects.RemoteAppointmentLocation.self
    ]
  )
}