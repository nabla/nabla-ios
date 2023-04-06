// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class ConversationsEventsSubscription: GraphQLSubscription {
    static let operationName: String = "ConversationsEvents"
    static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        subscription ConversationsEvents {
          conversations {
            __typename
            event {
              __typename
              ... on SubscriptionReadinessEvent {
                isReady
              }
              ... on ConversationCreatedEvent {
                conversation {
                  __typename
                  ...ConversationFragment
                }
              }
              ... on ConversationUpdatedEvent {
                conversation {
                  __typename
                  ...ConversationFragment
                }
              }
              ... on ConversationDeletedEvent {
                conversationId
              }
            }
          }
        }
        """#,
        fragments: [ConversationFragment.self, MessageFragment.self, MessageAuthorFragment.self, ProviderFragment.self, EphemeralUrlFragment.self, PatientFragment.self, SystemMessageFragment.self, MessageContentFragment.self, TextMessageContentFragment.self, ImageMessageContentFragment.self, VideoMessageContentFragment.self, DocumentMessageContentFragment.self, AudioMessageContentFragment.self, LivekitRoomMessageContentFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self, ReplyMessageFragment.self, ProviderInConversationFragment.self]
      ))

    init() {}

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Subscription }
      static var __selections: [ApolloAPI.Selection] { [
        .field("conversations", Conversations?.self),
      ] }

      var conversations: Conversations? { __data["conversations"] }

      /// Conversations
      ///
      /// Parent Type: `ConversationsEventOutput`
      struct Conversations: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationsEventOutput }
        static var __selections: [ApolloAPI.Selection] { [
          .field("event", Event.self),
        ] }

        var event: Event { __data["event"] }

        /// Conversations.Event
        ///
        /// Parent Type: `ConversationsEvent`
        struct Event: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: ApolloAPI.ParentType { GQL.Unions.ConversationsEvent }
          static var __selections: [ApolloAPI.Selection] { [
            .inlineFragment(AsSubscriptionReadinessEvent.self),
            .inlineFragment(AsConversationCreatedEvent.self),
            .inlineFragment(AsConversationUpdatedEvent.self),
            .inlineFragment(AsConversationDeletedEvent.self),
          ] }

          var asSubscriptionReadinessEvent: AsSubscriptionReadinessEvent? { _asInlineFragment() }
          var asConversationCreatedEvent: AsConversationCreatedEvent? { _asInlineFragment() }
          var asConversationUpdatedEvent: AsConversationUpdatedEvent? { _asInlineFragment() }
          var asConversationDeletedEvent: AsConversationDeletedEvent? { _asInlineFragment() }

          /// Conversations.Event.AsSubscriptionReadinessEvent
          ///
          /// Parent Type: `SubscriptionReadinessEvent`
          struct AsSubscriptionReadinessEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.SubscriptionReadinessEvent }
            static var __selections: [ApolloAPI.Selection] { [
              .field("isReady", Bool.self),
            ] }

            var isReady: Bool { __data["isReady"] }
          }

          /// Conversations.Event.AsConversationCreatedEvent
          ///
          /// Parent Type: `ConversationCreatedEvent`
          struct AsConversationCreatedEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationCreatedEvent }
            static var __selections: [ApolloAPI.Selection] { [
              .field("conversation", Conversation.self),
            ] }

            var conversation: Conversation { __data["conversation"] }

            /// Conversations.Event.AsConversationCreatedEvent.Conversation
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

              /// Conversations.Event.AsConversationCreatedEvent.Conversation.LastMessage
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

                /// Conversations.Event.AsConversationCreatedEvent.Conversation.LastMessage.ReplyTo
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

              /// Conversations.Event.AsConversationCreatedEvent.Conversation.PictureUrl
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

              /// Conversations.Event.AsConversationCreatedEvent.Conversation.Provider
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

                /// Conversations.Event.AsConversationCreatedEvent.Conversation.Provider.Provider
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

                  /// Conversations.Event.AsConversationCreatedEvent.Conversation.Provider.Provider.AvatarUrl
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

          /// Conversations.Event.AsConversationUpdatedEvent
          ///
          /// Parent Type: `ConversationUpdatedEvent`
          struct AsConversationUpdatedEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationUpdatedEvent }
            static var __selections: [ApolloAPI.Selection] { [
              .field("conversation", Conversation.self),
            ] }

            var conversation: Conversation { __data["conversation"] }

            /// Conversations.Event.AsConversationUpdatedEvent.Conversation
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

              /// Conversations.Event.AsConversationUpdatedEvent.Conversation.LastMessage
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

                /// Conversations.Event.AsConversationUpdatedEvent.Conversation.LastMessage.ReplyTo
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

              /// Conversations.Event.AsConversationUpdatedEvent.Conversation.PictureUrl
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

              /// Conversations.Event.AsConversationUpdatedEvent.Conversation.Provider
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

                /// Conversations.Event.AsConversationUpdatedEvent.Conversation.Provider.Provider
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

                  /// Conversations.Event.AsConversationUpdatedEvent.Conversation.Provider.Provider.AvatarUrl
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

          /// Conversations.Event.AsConversationDeletedEvent
          ///
          /// Parent Type: `ConversationDeletedEvent`
          struct AsConversationDeletedEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationDeletedEvent }
            static var __selections: [ApolloAPI.Selection] { [
              .field("conversationId", GQL.UUID.self),
            ] }

            var conversationId: GQL.UUID { __data["conversationId"] }
          }
        }
      }
    }
  }

}