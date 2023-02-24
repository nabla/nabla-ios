// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct PatientFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment PatientFragment on Patient {
        __typename
        id
        isMe
        displayName
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.Patient }
    static var __selections: [ApolloAPI.Selection] { [
      .field("id", GQL.UUID.self),
      .field("isMe", Bool.self),
      .field("displayName", String.self),
    ] }

    var id: GQL.UUID { __data["id"] }
    var isMe: Bool { __data["isMe"] }
    var displayName: String { __data["displayName"] }
  }

}