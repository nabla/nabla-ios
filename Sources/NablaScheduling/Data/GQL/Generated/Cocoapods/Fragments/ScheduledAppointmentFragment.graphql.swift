// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct ScheduledAppointmentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ScheduledAppointmentFragment on UpcomingAppointment {
        __typename
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.UpcomingAppointment }
    static var __selections: [Apollo.Selection] { [
    ] }
  }

}