// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct ProviderFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ProviderFragment on Provider {
        __typename
        id
        prefix
        firstName
        lastName
        title
        avatarUrl {
          __typename
          url
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.Provider }
    static var __selections: [ApolloAPI.Selection] { [
      .field("id", GQL.UUID.self),
      .field("prefix", String?.self),
      .field("firstName", String.self),
      .field("lastName", String.self),
      .field("title", String?.self),
      .field("avatarUrl", AvatarUrl?.self),
    ] }

    var id: GQL.UUID { __data["id"] }
    var prefix: String? { __data["prefix"] }
    var firstName: String { __data["firstName"] }
    var lastName: String { __data["lastName"] }
    var title: String? { __data["title"] }
    var avatarUrl: AvatarUrl? { __data["avatarUrl"] }

    /// AvatarUrl
    ///
    /// Parent Type: `EphemeralUrl`
    struct AvatarUrl: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.EphemeralUrl }
      static var __selections: [ApolloAPI.Selection] { [
        .field("url", String.self),
      ] }

      var url: String { __data["url"] }
    }
  }

}