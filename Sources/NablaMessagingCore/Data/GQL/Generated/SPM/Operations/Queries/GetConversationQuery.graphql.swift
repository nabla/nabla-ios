// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class GetConversationQuery: GraphQLQuery {
    static let operationName: String = "GetConversation"
    static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetConversation($id: UUID!) {
          conversation(id: $id) {
            __typename
            conversation {
              __typename
              ...ConversationFragment
            }
          }
        }
        """#,
        fragments: [ConversationFragment.self, EphemeralUrlFragment.self, ProviderInConversationFragment.self, ProviderFragment.self]
      ))

    var id: UUID

    init(id: UUID) {
      self.id = id
    }

    var __variables: Variables? { ["id": id] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("conversation", Conversation.self, arguments: ["id": .variable("id")]),
      ] }

      var conversation: Conversation { __data["conversation"] }

      /// Conversation
      ///
      /// Parent Type: `ConversationOutput`
      struct Conversation: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationOutput }
        static var __selections: [ApolloAPI.Selection] { [
          .field("conversation", Conversation.self),
        ] }

        var conversation: Conversation { __data["conversation"] }

        /// Conversation.Conversation
        ///
        /// Parent Type: `Conversation`
        struct Conversation: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: ApolloAPI.ParentType { GQL.Objects.Conversation }
          static var __selections: [ApolloAPI.Selection] { [
            .fragment(ConversationFragment.self),
          ] }

          var id: GQL.UUID { __data["id"] }
          var title: String? { __data["title"] }
          var subtitle: String? { __data["subtitle"] }
          var lastMessagePreview: String? { __data["lastMessagePreview"] }
          var unreadMessageCount: Int { __data["unreadMessageCount"] }
          var inboxPreviewTitle: String { __data["inboxPreviewTitle"] }
          var updatedAt: GQL.DateTime { __data["updatedAt"] }
          var pictureUrl: PictureUrl? { __data["pictureUrl"] }
          var providers: [Provider] { __data["providers"] }
          var isLocked: Bool { __data["isLocked"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            var conversationFragment: ConversationFragment { _toFragment() }
          }

          /// Conversation.Conversation.PictureUrl
          ///
          /// Parent Type: `EphemeralUrl`
          struct PictureUrl: GQL.SelectionSet {
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

          /// Conversation.Conversation.Provider
          ///
          /// Parent Type: `ProviderInConversation`
          struct Provider: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.ProviderInConversation }

            var id: GQL.UUID { __data["id"] }
            var provider: Provider { __data["provider"] }
            var typingAt: GQL.DateTime? { __data["typingAt"] }
            var seenUntil: GQL.DateTime? { __data["seenUntil"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var providerInConversationFragment: ProviderInConversationFragment { _toFragment() }
            }

            /// Conversation.Conversation.Provider.Provider
            ///
            /// Parent Type: `Provider`
            struct Provider: GQL.SelectionSet {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: ApolloAPI.ParentType { GQL.Objects.Provider }

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

              /// Conversation.Conversation.Provider.Provider.AvatarUrl
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
      }
    }
  }

}