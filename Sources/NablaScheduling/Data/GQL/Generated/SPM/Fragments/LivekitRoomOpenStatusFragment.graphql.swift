// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct LivekitRoomOpenStatusFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment LivekitRoomOpenStatusFragment on LivekitRoomOpenStatus {
        __typename
        url
        token
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.LivekitRoomOpenStatus }
    static var __selections: [ApolloAPI.Selection] { [
      .field("url", String.self),
      .field("token", String.self),
    ] }

    var url: String { __data["url"] }
    var token: String { __data["token"] }
  }

}