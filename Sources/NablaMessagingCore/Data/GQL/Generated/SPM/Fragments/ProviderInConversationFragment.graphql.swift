// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct ProviderInConversationFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ProviderInConversationFragment on ProviderInConversation {
        __typename
        id
        provider {
          __typename
          ...ProviderFragment
        }
        typingAt
        seenUntil
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.ProviderInConversation }
    static var __selections: [ApolloAPI.Selection] { [
      .field("id", GQL.UUID.self),
      .field("provider", Provider.self),
      .field("typingAt", GQL.DateTime?.self),
      .field("seenUntil", GQL.DateTime?.self),
    ] }

    var id: GQL.UUID { __data["id"] }
    var provider: Provider { __data["provider"] }
    var typingAt: GQL.DateTime? { __data["typingAt"] }
    var seenUntil: GQL.DateTime? { __data["seenUntil"] }

    /// Provider
    ///
    /// Parent Type: `Provider`
    struct Provider: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Provider }
      static var __selections: [ApolloAPI.Selection] { [
        .fragment(ProviderFragment.self),
      ] }

      var id: GQL.UUID { __data["id"] }
      var avatarUrl: AvatarUrl? { __data["avatarUrl"] }
      var prefix: String? { __data["prefix"] }
      var firstName: String { __data["firstName"] }
      var lastName: String { __data["lastName"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var providerFragment: ProviderFragment { _toFragment() }
      }

      /// Provider.AvatarUrl
      ///
      /// Parent Type: `EphemeralUrl`
      struct AvatarUrl: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.EphemeralUrl }

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

}