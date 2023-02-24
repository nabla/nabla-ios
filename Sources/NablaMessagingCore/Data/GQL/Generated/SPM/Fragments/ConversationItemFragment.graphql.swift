// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct ConversationItemFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ConversationItemFragment on ConversationItem {
        __typename
        ... on Message {
          ...MessageFragment
        }
        ... on ConversationActivity {
          ...ConversationActivityFragment
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Unions.ConversationItem }
    static var __selections: [ApolloAPI.Selection] { [
      .inlineFragment(AsMessage.self),
      .inlineFragment(AsConversationActivity.self),
    ] }

    var asMessage: AsMessage? { _asInlineFragment() }
    var asConversationActivity: AsConversationActivity? { _asInlineFragment() }

    /// AsMessage
    ///
    /// Parent Type: `Message`
    struct AsMessage: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Message }
      static var __selections: [ApolloAPI.Selection] { [
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

      /// AsMessage.ReplyTo
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

    /// AsConversationActivity
    ///
    /// Parent Type: `ConversationActivity`
    struct AsConversationActivity: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationActivity }
      static var __selections: [ApolloAPI.Selection] { [
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

      /// AsConversationActivity.Content
      ///
      /// Parent Type: `ConversationActivityContent`
      struct Content: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Unions.ConversationActivityContent }

        var asProviderJoinedConversation: AsProviderJoinedConversation? { _asInlineFragment() }

        /// AsConversationActivity.Content.AsProviderJoinedConversation
        ///
        /// Parent Type: `ProviderJoinedConversation`
        struct AsProviderJoinedConversation: GQL.InlineFragment {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: ApolloAPI.ParentType { GQL.Objects.ProviderJoinedConversation }

          var provider: ConversationActivityFragment.Content.AsProviderJoinedConversation.Provider { __data["provider"] }
        }
      }
    }
  }

}