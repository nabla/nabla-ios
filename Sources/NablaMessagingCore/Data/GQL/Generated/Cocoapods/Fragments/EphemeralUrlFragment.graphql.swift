// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct EphemeralUrlFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment EphemeralUrlFragment on EphemeralUrl {
        __typename
        expiresAt
        url
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.EphemeralUrl }
    static var __selections: [Apollo.Selection] { [
      .field("expiresAt", GQL.DateTime.self),
      .field("url", String.self),
    ] }

    var expiresAt: GQL.DateTime { __data["expiresAt"] }
    var url: String { __data["url"] }
  }

}