// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class ConversationEventsSubscription: GraphQLSubscription {
    static let operationName: String = "ConversationEvents"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        subscription ConversationEvents($id: UUID!) {
          conversation(id: $id) {
            __typename
            event {
              __typename
              ... on SubscriptionReadinessEvent {
                isReady
              }
              ... on MessageCreatedEvent {
                message {
                  __typename
                  ...MessageFragment
                }
              }
              ... on MessageUpdatedEvent {
                message {
                  __typename
                  ...MessageFragment
                }
              }
              ... on TypingEvent {
                provider {
                  __typename
                  ...ProviderInConversationFragment
                }
              }
              ... on ConversationActivityCreated {
                activity {
                  __typename
                  ...ConversationActivityFragment
                }
              }
            }
          }
        }
        """#,
        fragments: [MessageFragment.self, MessageAuthorFragment.self, ProviderFragment.self, EphemeralUrlFragment.self, PatientFragment.self, SystemMessageFragment.self, MessageContentFragment.self, TextMessageContentFragment.self, ImageMessageContentFragment.self, VideoMessageContentFragment.self, DocumentMessageContentFragment.self, AudioMessageContentFragment.self, LivekitRoomMessageContentFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self, ReplyMessageFragment.self, ProviderInConversationFragment.self, ConversationActivityFragment.self, MaybeProviderFragment.self]
      ))

    var id: UUID

    init(id: UUID) {
      self.id = id
    }

    var __variables: Variables? { ["id": id] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Subscription }
      static var __selections: [Apollo.Selection] { [
        .field("conversation", Conversation?.self, arguments: ["id": .variable("id")]),
      ] }

      var conversation: Conversation? { __data["conversation"] }

      /// Conversation
      ///
      /// Parent Type: `ConversationEventOutput`
      struct Conversation: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.ConversationEventOutput }
        static var __selections: [Apollo.Selection] { [
          .field("event", Event.self),
        ] }

        var event: Event { __data["event"] }

        /// Conversation.Event
        ///
        /// Parent Type: `ConversationEvent`
        struct Event: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Unions.ConversationEvent }
          static var __selections: [Apollo.Selection] { [
            .inlineFragment(AsSubscriptionReadinessEvent.self),
            .inlineFragment(AsMessageCreatedEvent.self),
            .inlineFragment(AsMessageUpdatedEvent.self),
            .inlineFragment(AsTypingEvent.self),
            .inlineFragment(AsConversationActivityCreated.self),
          ] }

          var asSubscriptionReadinessEvent: AsSubscriptionReadinessEvent? { _asInlineFragment() }
          var asMessageCreatedEvent: AsMessageCreatedEvent? { _asInlineFragment() }
          var asMessageUpdatedEvent: AsMessageUpdatedEvent? { _asInlineFragment() }
          var asTypingEvent: AsTypingEvent? { _asInlineFragment() }
          var asConversationActivityCreated: AsConversationActivityCreated? { _asInlineFragment() }

          /// Conversation.Event.AsSubscriptionReadinessEvent
          ///
          /// Parent Type: `SubscriptionReadinessEvent`
          struct AsSubscriptionReadinessEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.SubscriptionReadinessEvent }
            static var __selections: [Apollo.Selection] { [
              .field("isReady", Bool.self),
            ] }

            var isReady: Bool { __data["isReady"] }
          }

          /// Conversation.Event.AsMessageCreatedEvent
          ///
          /// Parent Type: `MessageCreatedEvent`
          struct AsMessageCreatedEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.MessageCreatedEvent }
            static var __selections: [Apollo.Selection] { [
              .field("message", Message.self),
            ] }

            var message: Message { __data["message"] }

            /// Conversation.Event.AsMessageCreatedEvent.Message
            ///
            /// Parent Type: `Message`
            struct Message: GQL.SelectionSet {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.Message }
              static var __selections: [Apollo.Selection] { [
                .fragment(MessageFragment.self),
              ] }

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

              /// Conversation.Event.AsMessageCreatedEvent.Message.ReplyTo
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
          }

          /// Conversation.Event.AsMessageUpdatedEvent
          ///
          /// Parent Type: `MessageUpdatedEvent`
          struct AsMessageUpdatedEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.MessageUpdatedEvent }
            static var __selections: [Apollo.Selection] { [
              .field("message", Message.self),
            ] }

            var message: Message { __data["message"] }

            /// Conversation.Event.AsMessageUpdatedEvent.Message
            ///
            /// Parent Type: `Message`
            struct Message: GQL.SelectionSet {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.Message }
              static var __selections: [Apollo.Selection] { [
                .fragment(MessageFragment.self),
              ] }

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

              /// Conversation.Event.AsMessageUpdatedEvent.Message.ReplyTo
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
          }

          /// Conversation.Event.AsTypingEvent
          ///
          /// Parent Type: `TypingEvent`
          struct AsTypingEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.TypingEvent }
            static var __selections: [Apollo.Selection] { [
              .field("provider", Provider.self),
            ] }

            var provider: Provider { __data["provider"] }

            /// Conversation.Event.AsTypingEvent.Provider
            ///
            /// Parent Type: `ProviderInConversation`
            struct Provider: GQL.SelectionSet {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.ProviderInConversation }
              static var __selections: [Apollo.Selection] { [
                .fragment(ProviderInConversationFragment.self),
              ] }

              var id: GQL.UUID { __data["id"] }
              var provider: Provider { __data["provider"] }
              var typingAt: GQL.DateTime? { __data["typingAt"] }
              var seenUntil: GQL.DateTime? { __data["seenUntil"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var providerInConversationFragment: ProviderInConversationFragment { _toFragment() }
              }

              /// Conversation.Event.AsTypingEvent.Provider.Provider
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

                /// Conversation.Event.AsTypingEvent.Provider.Provider.AvatarUrl
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

          /// Conversation.Event.AsConversationActivityCreated
          ///
          /// Parent Type: `ConversationActivityCreated`
          struct AsConversationActivityCreated: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.ConversationActivityCreated }
            static var __selections: [Apollo.Selection] { [
              .field("activity", Activity.self),
            ] }

            var activity: Activity { __data["activity"] }

            /// Conversation.Event.AsConversationActivityCreated.Activity
            ///
            /// Parent Type: `ConversationActivity`
            struct Activity: GQL.SelectionSet {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.ConversationActivity }
              static var __selections: [Apollo.Selection] { [
                .fragment(ConversationActivityFragment.self),
              ] }

              var id: GQL.UUID { __data["id"] }
              var activityTime: GQL.DateTime { __data["activityTime"] }
              var content: Content { __data["content"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var conversationActivityFragment: ConversationActivityFragment { _toFragment() }
              }

              /// Conversation.Event.AsConversationActivityCreated.Activity.Content
              ///
              /// Parent Type: `ConversationActivityContent`
              struct Content: GQL.SelectionSet {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: Apollo.ParentType { GQL.Unions.ConversationActivityContent }

                var asProviderJoinedConversation: AsProviderJoinedConversation? { _asInlineFragment() }

                /// Conversation.Event.AsConversationActivityCreated.Activity.Content.AsProviderJoinedConversation
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