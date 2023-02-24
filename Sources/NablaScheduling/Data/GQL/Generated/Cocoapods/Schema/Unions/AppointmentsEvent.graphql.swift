// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension GQL.Unions {
  static let AppointmentsEvent = Union(
    name: "AppointmentsEvent",
    possibleTypes: [
      GQL.Objects.SubscriptionReadinessEvent.self,
      GQL.Objects.AppointmentCreatedEvent.self,
      GQL.Objects.AppointmentUpdatedEvent.self,
      GQL.Objects.AppointmentCancelledEvent.self
    ]
  )
}