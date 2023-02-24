// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class CreateConversationMutation: GraphQLMutation {
    static let operationName: String = "CreateConversation"
    static let document: ApolloAPI.DocumentType = .notPersisted(
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
        fragments: [ConversationFragment.self, EphemeralUrlFragment.self, ProviderInConversationFragment.self, ProviderFragment.self]
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

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
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

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.CreateConversationOutput }
        static var __selections: [ApolloAPI.Selection] { [
          .field("conversation", Conversation.self),
        ] }

        var conversation: Conversation { __data["conversation"] }

        /// CreateConversation.Conversation
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

          /// CreateConversation.Conversation.PictureUrl
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

          /// CreateConversation.Conversation.Provider
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

            /// CreateConversation.Conversation.Provider.Provider
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

              /// CreateConversation.Conversation.Provider.Provider.AvatarUrl
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