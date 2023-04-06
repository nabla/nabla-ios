// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class CreateConversationMutation: GraphQLMutation {
    static let operationName: String = "CreateConversation"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation CreateConversation($title: String, $providerIds: [UUID!], $initialMessage: SendMessageInput) {
          createConversation(
            title: $title
            providerIds: $providerIds
            initialMessage: $initialMessage
          ) {
            __typename
            conversation {
              __typename
              ...ConversationFragment
            }
          }
        }
        """#,
        fragments: [ConversationFragment.self, MessageFragment.self, MessageAuthorFragment.self, ProviderFragment.self, EphemeralUrlFragment.self, PatientFragment.self, SystemMessageFragment.self, MessageContentFragment.self, TextMessageContentFragment.self, ImageMessageContentFragment.self, VideoMessageContentFragment.self, DocumentMessageContentFragment.self, AudioMessageContentFragment.self, LivekitRoomMessageContentFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self, ReplyMessageFragment.self, ProviderInConversationFragment.self]
      ))

    var title: GraphQLNullable<String>
    var providerIds: GraphQLNullable<[UUID]>
    var initialMessage: GraphQLNullable<SendMessageInput>

    init(
      title: GraphQLNullable<String>,
      providerIds: GraphQLNullable<[UUID]>,
      initialMessage: GraphQLNullable<SendMessageInput>
    ) {
      self.title = title
      self.providerIds = providerIds
      self.initialMessage = initialMessage
    }

    var __variables: Variables? { [
      "title": title,
      "providerIds": providerIds,
      "initialMessage": initialMessage
    ] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("createConversation", CreateConversation.self, arguments: [
          "title": .variable("title"),
          "providerIds": .variable("providerIds"),
          "initialMessage": .variable("initialMessage")
        ]),
      ] }

      var createConversation: CreateConversation { __data["createConversation"] }

      /// CreateConversation
      ///
      /// Parent Type: `CreateConversationOutput`
      struct CreateConversation: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.CreateConversationOutput }
        static var __selections: [Apollo.Selection] { [
          .field("conversation", Conversation.self),
        ] }

        var conversation: Conversation { __data["conversation"] }

        /// CreateConversation.Conversation
        ///
        /// Parent Type: `Conversation`
        struct Conversation: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.Conversation }
          static var __selections: [Apollo.Selection] { [
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

          /// CreateConversation.Conversation.LastMessage
          ///
          /// Parent Type: `Message`
          struct LastMessage: GQL.SelectionSet {
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

              var messageFragment: MessageFragment { _toFragment() }
            }

            /// CreateConversation.Conversation.LastMessage.ReplyTo
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

          /// CreateConversation.Conversation.PictureUrl
          ///
          /// Parent Type: `EphemeralUrl`
          struct PictureUrl: GQL.SelectionSet {
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

          /// CreateConversation.Conversation.Provider
          ///
          /// Parent Type: `ProviderInConversation`
          struct Provider: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.ProviderInConversation }

            var id: GQL.UUID { __data["id"] }
            var provider: Provider { __data["provider"] }
            var typingAt: GQL.DateTime? { __data["typingAt"] }
            var seenUntil: GQL.DateTime? { __data["seenUntil"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var providerInConversationFragment: ProviderInConversationFragment { _toFragment() }
            }

            /// CreateConversation.Conversation.Provider.Provider
            ///
            /// Parent Type: `Provider`
            struct Provider: GQL.SelectionSet {
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
              }

              /// CreateConversation.Conversation.Provider.Provider.AvatarUrl
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
          }
        }
      }
    }
  }

}