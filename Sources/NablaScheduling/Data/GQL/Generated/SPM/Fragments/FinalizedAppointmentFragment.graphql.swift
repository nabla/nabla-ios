// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct FinalizedAppointmentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment FinalizedAppointmentFragment on FinalizedAppointment {
        __typename
        _
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.FinalizedAppointment }
    static var __selections: [ApolloAPI.Selection] { [
      .field("_", GraphQLEnum<GQL.EmptyObject>.self),
    ] }

    var `_`: GraphQLEnum<GQL.EmptyObject> { __data["_"] }
  }

}