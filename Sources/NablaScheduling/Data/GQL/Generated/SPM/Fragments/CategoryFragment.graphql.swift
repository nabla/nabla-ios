// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct CategoryFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment CategoryFragment on AppointmentCategory {
        __typename
        id
        name
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.AppointmentCategory }
    static var __selections: [ApolloAPI.Selection] { [
      .field("id", GQL.UUID.self),
      .field("name", String.self),
    ] }

    var id: GQL.UUID { __data["id"] }
    var name: String { __data["name"] }
  }

}