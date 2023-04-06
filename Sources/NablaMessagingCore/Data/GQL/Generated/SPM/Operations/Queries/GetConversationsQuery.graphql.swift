// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class GetConversationsQuery: GraphQLQuery {
    static let operationName: String = "GetConversations"
    static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetConversations($page: OpaqueCursorPage!) {
          conversations(page: $page) {
            __typename
            conversations {
              __typename
              ...ConversationFragment
            }
            nextCursor
            hasMore
          }
        }
        """#,
        fragments: [ConversationFragment.self, MessageFragment.self, MessageAuthorFragment.self, ProviderFragment.self, EphemeralUrlFragment.self, PatientFragment.self, SystemMessageFragment.self, MessageContentFragment.self, TextMessageContentFragment.self, ImageMessageContentFragment.self, VideoMessageContentFragment.self, DocumentMessageContentFragment.self, AudioMessageContentFragment.self, LivekitRoomMessageContentFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self, ReplyMessageFragment.self, ProviderInConversationFragment.self]
      ))

    var page: OpaqueCursorPage

    init(page: OpaqueCursorPage) {
      self.page = page
    }

    var __variables: Variables? { ["page": page] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("conversations", Conversations.self, arguments: ["page": .variable("page")]),
      ] }

      var conversations: Conversations { __data["conversations"] }

      /// Conversations
      ///
      /// Parent Type: `ConversationsOutput`
      struct Conversations: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationsOutput }
        static var __selections: [ApolloAPI.Selection] { [
          .field("conversations", [Conversation].self),
          .field("nextCursor", String?.self),
          .field("hasMore", Bool.self),
        ] }

        var conversations: [Conversation] { __data["conversations"] }
        var nextCursor: String? { __data["nextCursor"] }
        var hasMore: Bool { __data["hasMore"] }

        /// Conversations.Conversation
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
          var lastMessage: LastMessage? { __data["lastMessage"] }
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

          /// Conversations.Conversation.LastMessage
          ///
          /// Parent Type: `Message`
          struct LastMessage: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.Message }

            var id: GQL.UUID { __data["id"] }
            var clientId: GQL.UUID? { __data["clientId"] }
            var createdAt: GQL.DateTime { __data["createdAt"] }
            var author: MessageFragment.Author { __data["author"] }
            var content: MessageFragment.Content { __data["content"] }
            var replyTo: ReplyTo? { __data["replyTo"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var messageFragment: MessageFragment { _toFragment() }
            }

            /// Conversations.Conversation.LastMessage.ReplyTo
            ///
            /// Parent Type: `Message`
            struct ReplyTo: GQL.SelectionSet {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: ApolloAPI.ParentType { GQL.Objects.Message }

              var id: GQL.UUID { __data["id"] }
              var clientId: GQL.UUID? { __data["clientId"] }
              var createdAt: GQL.DateTime { __data["createdAt"] }
              var author: ReplyMessageFragment.Author { __data["author"] }
              var content: ReplyMessageFragment.Content { __data["content"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var replyMessageFragment: ReplyMessageFragment { _toFragment() }
              }
            }
          }

          /// Conversations.Conversation.PictureUrl
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

          /// Conversations.Conversation.Provider
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

            /// Conversations.Conversation.Provider.Provider
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

              /// Conversations.Conversation.Provider.Provider.AvatarUrl
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