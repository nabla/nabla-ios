// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct MaybeProviderFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment MaybeProviderFragment on MaybeProvider {
        __typename
        ... on Provider {
          ...ProviderFragment
        }
        ... on DeletedProvider {
          _
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Unions.MaybeProvider }
    static var __selections: [Apollo.Selection] { [
      .inlineFragment(AsProvider.self),
      .inlineFragment(AsDeletedProvider.self),
    ] }

    var asProvider: AsProvider? { _asInlineFragment() }
    var asDeletedProvider: AsDeletedProvider? { _asInlineFragment() }

    /// AsProvider
    ///
    /// Parent Type: `Provider`
    struct AsProvider: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Provider }
      static var __selections: [Apollo.Selection] { [
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

      /// AsProvider.AvatarUrl
      ///
      /// Parent Type: `EphemeralUrl`
      struct AvatarUrl: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.EphemeralUrl }

        var expiresAt: GQL.DateTime { __data["expiresAt"] }
        var url: String { __data["url"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var ephemeralUrlFragment: EphemeralUrlFragment { _toFragment() }
        }
      }
    }

    /// AsDeletedProvider
    ///
    /// Parent Type: `DeletedProvider`
    struct AsDeletedProvider: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.DeletedProvider }
      static var __selections: [Apollo.Selection] { [
        .field("_", GraphQLEnum<GQL.EmptyObject>.self),
      ] }

      var `_`: GraphQLEnum<GQL.EmptyObject> { __data["_"] }
    }
  }

}