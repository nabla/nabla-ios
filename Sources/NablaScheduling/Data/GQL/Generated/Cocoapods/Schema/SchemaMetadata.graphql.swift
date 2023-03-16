// @generated
// This file was automatically generated and should not be edited.

import Apollo

protocol GQL_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == GQL.SchemaMetadata {}

protocol GQL_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == GQL.SchemaMetadata {}

protocol GQL_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == GQL.SchemaMetadata {}

protocol GQL_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == GQL.SchemaMetadata {}

extension GQL {
  typealias ID = String

  typealias SelectionSet = GQL_SelectionSet

  typealias InlineFragment = GQL_InlineFragment

  typealias MutableSelectionSet = GQL_MutableSelectionSet

  typealias MutableInlineFragment = GQL_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Mutation": return GQL.Objects.Mutation
      case "ScheduleAppointmentOutput": return GQL.Objects.ScheduleAppointmentOutput
      case "Appointment": return GQL.Objects.Appointment
      case "Provider": return GQL.Objects.Provider
      case "EphemeralUrl": return GQL.Objects.EphemeralUrl
      case "PendingAppointment": return GQL.Objects.PendingAppointment
      case "UpcomingAppointment": return GQL.Objects.UpcomingAppointment
      case "FinalizedAppointment": return GQL.Objects.FinalizedAppointment
      case "AppointmentSchedulingRequiresPayment": return GQL.Objects.AppointmentSchedulingRequiresPayment
      case "Price": return GQL.Objects.Price
      case "PhysicalAppointmentLocation": return GQL.Objects.PhysicalAppointmentLocation
      case "RemoteAppointmentLocation": return GQL.Objects.RemoteAppointmentLocation
      case "Address": return GQL.Objects.Address
      case "LivekitRoom": return GQL.Objects.LivekitRoom
      case "LivekitRoomOpenStatus": return GQL.Objects.LivekitRoomOpenStatus
      case "LivekitRoomClosedStatus": return GQL.Objects.LivekitRoomClosedStatus
      case "CancelAppointmentOutput": return GQL.Objects.CancelAppointmentOutput
      case "Query": return GQL.Objects.Query
      case "AppointmentCategoriesOutput": return GQL.Objects.AppointmentCategoriesOutput
      case "AppointmentCategory": return GQL.Objects.AppointmentCategory
      case "ProviderOutput": return GQL.Objects.ProviderOutput
      case "AppointmentConfirmationConsentsOutput": return GQL.Objects.AppointmentConfirmationConsentsOutput
      case "AppointmentOutput": return GQL.Objects.AppointmentOutput
      case "AppointmentAvailableLocationsOutput": return GQL.Objects.AppointmentAvailableLocationsOutput
      case "AppointmentsPage": return GQL.Objects.AppointmentsPage
      case "AppointmentCategoryOutput": return GQL.Objects.AppointmentCategoryOutput
      case "AvailableSlotsPage": return GQL.Objects.AvailableSlotsPage
      case "AvailabilitySlot": return GQL.Objects.AvailabilitySlot
      case "Subscription": return GQL.Objects.Subscription
      case "AppointmentsEventOutput": return GQL.Objects.AppointmentsEventOutput
      case "SubscriptionReadinessEvent": return GQL.Objects.SubscriptionReadinessEvent
      case "AppointmentCreatedEvent": return GQL.Objects.AppointmentCreatedEvent
      case "AppointmentUpdatedEvent": return GQL.Objects.AppointmentUpdatedEvent
      case "AppointmentCancelledEvent": return GQL.Objects.AppointmentCancelledEvent
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}