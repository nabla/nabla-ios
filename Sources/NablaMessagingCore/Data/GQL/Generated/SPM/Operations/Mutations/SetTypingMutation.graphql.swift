// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class SetTypingMutation: GraphQLMutation {
    static let operationName: String = "SetTyping"
    static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation SetTyping($conversationId: UUID!, $isTyping: Boolean!) {
          setTyping(conversationId: $conversationId, isTyping: $isTyping) {
            __typename
          }
        }
        """#
      ))

    var conversationId: UUID
    var isTyping: Bool

    init(
      conversationId: UUID,
      isTyping: Bool
    ) {
      self.conversationId = conversationId
      self.isTyping = isTyping
    }

    var __variables: Variables? { [
      "conversationId": conversationId,
      "isTyping": isTyping
    ] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("setTyping", SetTyping.self, arguments: [
          "conversationId": .variable("conversationId"),
          "isTyping": .variable("isTyping")
        ]),
      ] }

      var setTyping: SetTyping { __data["setTyping"] }

      /// SetTyping
      ///
      /// Parent Type: `SetTypingOutput`
      struct SetTyping: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.SetTypingOutput }
        static var __selections: [ApolloAPI.Selection] { [
        ] }
      }
    }
  }

}