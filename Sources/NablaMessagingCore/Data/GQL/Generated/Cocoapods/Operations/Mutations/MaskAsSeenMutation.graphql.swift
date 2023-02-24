// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class MaskAsSeenMutation: GraphQLMutation {
    static let operationName: String = "MaskAsSeen"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation MaskAsSeen($conversationId: UUID!) {
          markAsSeen(conversationId: $conversationId) {
            __typename
            conversation {
              __typename
              id
              unreadMessageCount
            }
          }
        }
        """#
      ))

    var conversationId: UUID

    init(conversationId: UUID) {
      self.conversationId = conversationId
    }

    var __variables: Variables? { ["conversationId": conversationId] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("markAsSeen", MarkAsSeen.self, arguments: ["conversationId": .variable("conversationId")]),
      ] }

      var markAsSeen: MarkAsSeen { __data["markAsSeen"] }

      /// MarkAsSeen
      ///
      /// Parent Type: `MarkConversationAsSeenOutput`
      struct MarkAsSeen: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.MarkConversationAsSeenOutput }
        static var __selections: [Apollo.Selection] { [
          .field("conversation", Conversation.self),
        ] }

        var conversation: Conversation { __data["conversation"] }

        /// MarkAsSeen.Conversation
        ///
        /// Parent Type: `Conversation`
        struct Conversation: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.Conversation }
          static var __selections: [Apollo.Selection] { [
            .field("id", GQL.UUID.self),
            .field("unreadMessageCount", Int.self),
          ] }

          var id: GQL.UUID { __data["id"] }
          var unreadMessageCount: Int { __data["unreadMessageCount"] }
        }
      }
    }
  }

}