// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct ProviderFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ProviderFragment on Provider {
        __typename
        id
        avatarUrl {
          __typename
          ...EphemeralUrlFragment
        }
        prefix
        firstName
        lastName
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.Provider }
    static var __selections: [Apollo.Selection] { [
      .field("id", GQL.UUID.self),
      .field("avatarUrl", AvatarUrl?.self),
      .field("prefix", String?.self),
      .field("firstName", String.self),
      .field("lastName", String.self),
    ] }

    var id: GQL.UUID { __data["id"] }
    var avatarUrl: AvatarUrl? { __data["avatarUrl"] }
    var prefix: String? { __data["prefix"] }
    var firstName: String { __data["firstName"] }
    var lastName: String { __data["lastName"] }

    /// AvatarUrl
    ///
    /// Parent Type: `EphemeralUrl`
    struct AvatarUrl: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.EphemeralUrl }
      static var __selections: [Apollo.Selection] { [
        .fragment(EphemeralUrlFragment.self),
      ] }

      var expiresAt: GQL.DateTime { __data["expiresAt"] }
      var url: String { __data["url"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var ephemeralUrlFragment: EphemeralUrlFragment { _toFragment() }
      }
    }
  }

}