// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct UpcomingAppointmentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment UpcomingAppointmentFragment on UpcomingAppointment {
        __typename
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.UpcomingAppointment }
    static var __selections: [ApolloAPI.Selection] { [
    ] }
  }

}