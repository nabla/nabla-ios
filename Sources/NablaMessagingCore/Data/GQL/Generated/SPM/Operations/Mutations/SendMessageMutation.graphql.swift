// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class SendMessageMutation: GraphQLMutation {
    static let operationName: String = "SendMessage"
    static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation SendMessage($conversationId: UUID!, $input: SendMessageInput!) {
          sendMessageV2(conversationId: $conversationId, input: $input) {
            __typename
            message {
              __typename
              ...MessageFragment
            }
          }
        }
        """#,
        fragments: [MessageFragment.self, MessageAuthorFragment.self, ProviderFragment.self, EphemeralUrlFragment.self, PatientFragment.self, SystemMessageFragment.self, MessageContentFragment.self, TextMessageContentFragment.self, ImageMessageContentFragment.self, VideoMessageContentFragment.self, DocumentMessageContentFragment.self, AudioMessageContentFragment.self, LivekitRoomMessageContentFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self, ReplyMessageFragment.self]
      ))

    var conversationId: UUID
    var input: SendMessageInput

    init(
      conversationId: UUID,
      input: SendMessageInput
    ) {
      self.conversationId = conversationId
      self.input = input
    }

    var __variables: Variables? { [
      "conversationId": conversationId,
      "input": input
    ] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("sendMessageV2", SendMessageV2.self, arguments: [
          "conversationId": .variable("conversationId"),
          "input": .variable("input")
        ]),
      ] }

      var sendMessageV2: SendMessageV2 { __data["sendMessageV2"] }

      /// SendMessageV2
      ///
      /// Parent Type: `SendMessageOutput`
      struct SendMessageV2: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.SendMessageOutput }
        static var __selections: [ApolloAPI.Selection] { [
          .field("message", Message.self),
        ] }

        var message: Message { __data["message"] }

        /// SendMessageV2.Message
        ///
        /// Parent Type: `Message`
        struct Message: GQL.SelectionSet {
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

          /// SendMessageV2.Message.ReplyTo
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
      }
    }
  }

}