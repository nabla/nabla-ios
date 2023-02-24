// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct ConversationActivityFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ConversationActivityFragment on ConversationActivity {
        __typename
        id
        activityTime
        content {
          __typename
          ... on ProviderJoinedConversation {
            provider {
              __typename
              ...MaybeProviderFragment
            }
          }
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.ConversationActivity }
    static var __selections: [Apollo.Selection] { [
      .field("id", GQL.UUID.self),
      .field("activityTime", GQL.DateTime.self),
      .field("content", Content.self),
    ] }

    var id: GQL.UUID { __data["id"] }
    var activityTime: GQL.DateTime { __data["activityTime"] }
    var content: Content { __data["content"] }

    /// Content
    ///
    /// Parent Type: `ConversationActivityContent`
    struct Content: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Unions.ConversationActivityContent }
      static var __selections: [Apollo.Selection] { [
        .inlineFragment(AsProviderJoinedConversation.self),
      ] }

      var asProviderJoinedConversation: AsProviderJoinedConversation? { _asInlineFragment() }

      /// Content.AsProviderJoinedConversation
      ///
      /// Parent Type: `ProviderJoinedConversation`
      struct AsProviderJoinedConversation: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.ProviderJoinedConversation }
        static var __selections: [Apollo.Selection] { [
          .field("provider", Provider.self),
        ] }

        var provider: Provider { __data["provider"] }

        /// Content.AsProviderJoinedConversation.Provider
        ///
        /// Parent Type: `MaybeProvider`
        struct Provider: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Unions.MaybeProvider }
          static var __selections: [Apollo.Selection] { [
            .fragment(MaybeProviderFragment.self),
          ] }

          var asProvider: AsProvider? { _asInlineFragment() }
          var asDeletedProvider: AsDeletedProvider? { _asInlineFragment() }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            var maybeProviderFragment: MaybeProviderFragment { _toFragment() }
          }

          /// Content.AsProviderJoinedConversation.Provider.AsProvider
          ///
          /// Parent Type: `Provider`
          struct AsProvider: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.Provider }

            var id: GQL.UUID { __data["id"] }
            var avatarUrl: AvatarUrl? { __data["avatarUrl"] }
            var prefix: String? { __data["prefix"] }
            var firstName: String { __data["firstName"] }
            var lastName: String { __data["lastName"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var providerFragment: ProviderFragment { _toFragment() }
              var maybeProviderFragment: MaybeProviderFragment { _toFragment() }
            }

            /// Content.AsProviderJoinedConversation.Provider.AsProvider.AvatarUrl
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

          /// Content.AsProviderJoinedConversation.Provider.AsDeletedProvider
          ///
          /// Parent Type: `DeletedProvider`
          struct AsDeletedProvider: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.DeletedProvider }

            var `_`: GraphQLEnum<GQL.EmptyObject> { __data["_"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var maybeProviderFragment: MaybeProviderFragment { _toFragment() }
            }
          }
        }
      }
    }
  }

}