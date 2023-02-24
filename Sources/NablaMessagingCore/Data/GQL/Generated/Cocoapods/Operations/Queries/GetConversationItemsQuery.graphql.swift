// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class GetConversationItemsQuery: GraphQLQuery {
    static let operationName: String = "GetConversationItems"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetConversationItems($id: UUID!, $page: OpaqueCursorPage!) {
          conversation(id: $id) {
            __typename
            conversation {
              __typename
              id
              items(page: $page) {
                __typename
                hasMore
                nextCursor
                data {
                  __typename
                  ...ConversationItemFragment
                }
              }
            }
          }
        }
        """#,
        fragments: [ConversationItemFragment.self, MessageFragment.self, MessageAuthorFragment.self, ProviderFragment.self, EphemeralUrlFragment.self, PatientFragment.self, SystemMessageFragment.self, MessageContentFragment.self, TextMessageContentFragment.self, ImageMessageContentFragment.self, VideoMessageContentFragment.self, DocumentMessageContentFragment.self, AudioMessageContentFragment.self, LivekitRoomMessageContentFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self, ReplyMessageFragment.self, ConversationActivityFragment.self, MaybeProviderFragment.self]
      ))

    var id: UUID
    var page: OpaqueCursorPage

    init(
      id: UUID,
      page: OpaqueCursorPage
    ) {
      self.id = id
      self.page = page
    }

    var __variables: Variables? { [
      "id": id,
      "page": page
    ] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("conversation", Conversation.self, arguments: ["id": .variable("id")]),
      ] }

      var conversation: Conversation { __data["conversation"] }

      /// Conversation
      ///
      /// Parent Type: `ConversationOutput`
      struct Conversation: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.ConversationOutput }
        static var __selections: [Apollo.Selection] { [
          .field("conversation", Conversation.self),
        ] }

        var conversation: Conversation { __data["conversation"] }

        /// Conversation.Conversation
        ///
        /// Parent Type: `Conversation`
        struct Conversation: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.Conversation }
          static var __selections: [Apollo.Selection] { [
            .field("id", GQL.UUID.self),
            .field("items", Items.self, arguments: ["page": .variable("page")]),
          ] }

          var id: GQL.UUID { __data["id"] }
          var items: Items { __data["items"] }

          /// Conversation.Conversation.Items
          ///
          /// Parent Type: `ConversationItemsPage`
          struct Items: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.ConversationItemsPage }
            static var __selections: [Apollo.Selection] { [
              .field("hasMore", Bool.self),
              .field("nextCursor", String?.self),
              .field("data", [Datum?].self),
            ] }

            var hasMore: Bool { __data["hasMore"] }
            var nextCursor: String? { __data["nextCursor"] }
            var data: [Datum?] { __data["data"] }

            /// Conversation.Conversation.Items.Datum
            ///
            /// Parent Type: `ConversationItem`
            struct Datum: GQL.SelectionSet {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Unions.ConversationItem }
              static var __selections: [Apollo.Selection] { [
                .fragment(ConversationItemFragment.self),
              ] }

              var asMessage: AsMessage? { _asInlineFragment() }
              var asConversationActivity: AsConversationActivity? { _asInlineFragment() }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var conversationItemFragment: ConversationItemFragment { _toFragment() }
              }

              /// Conversation.Conversation.Items.Datum.AsMessage
              ///
              /// Parent Type: `Message`
              struct AsMessage: GQL.InlineFragment {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: Apollo.ParentType { GQL.Objects.Message }

                var id: GQL.UUID { __data["id"] }
                var clientId: GQL.UUID? { __data["clientId"] }
                var createdAt: GQL.DateTime { __data["createdAt"] }
                var author: MessageFragment.Author { __data["author"] }
                var content: MessageFragment.Content { __data["content"] }
                var replyTo: ReplyTo? { __data["replyTo"] }

                struct Fragments: FragmentContainer {
                  let __data: DataDict
                  init(data: DataDict) { __data = data }

                  var conversationItemFragment: ConversationItemFragment { _toFragment() }
                  var messageFragment: MessageFragment { _toFragment() }
                }

                /// Conversation.Conversation.Items.Datum.AsMessage.ReplyTo
                ///
                /// Parent Type: `Message`
                struct ReplyTo: GQL.SelectionSet {
                  let __data: DataDict
                  init(data: DataDict) { __data = data }

                  static var __parentType: Apollo.ParentType { GQL.Objects.Message }

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

              /// Conversation.Conversation.Items.Datum.AsConversationActivity
              ///
              /// Parent Type: `ConversationActivity`
              struct AsConversationActivity: GQL.InlineFragment {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: Apollo.ParentType { GQL.Objects.ConversationActivity }

                var id: GQL.UUID { __data["id"] }
                var activityTime: GQL.DateTime { __data["activityTime"] }
                var content: Content { __data["content"] }

                struct Fragments: FragmentContainer {
                  let __data: DataDict
                  init(data: DataDict) { __data = data }

                  var conversationItemFragment: ConversationItemFragment { _toFragment() }
                  var conversationActivityFragment: ConversationActivityFragment { _toFragment() }
                }

                /// Conversation.Conversation.Items.Datum.AsConversationActivity.Content
                ///
                /// Parent Type: `ConversationActivityContent`
                struct Content: GQL.SelectionSet {
                  let __data: DataDict
                  init(data: DataDict) { __data = data }

                  static var __parentType: Apollo.ParentType { GQL.Unions.ConversationActivityContent }

                  var asProviderJoinedConversation: AsProviderJoinedConversation? { _asInlineFragment() }

                  /// Conversation.Conversation.Items.Datum.AsConversationActivity.Content.AsProviderJoinedConversation
                  ///
                  /// Parent Type: `ProviderJoinedConversation`
                  struct AsProviderJoinedConversation: GQL.InlineFragment {
                    let __data: DataDict
                    init(data: DataDict) { __data = data }

                    static var __parentType: Apollo.ParentType { GQL.Objects.ProviderJoinedConversation }

                    var provider: ConversationActivityFragment.Content.AsProviderJoinedConversation.Provider { __data["provider"] }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

}