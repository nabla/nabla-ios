// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GQL.Unions {
  static let ConversationActivityContent = Union(
    name: "ConversationActivityContent",
    possibleTypes: [
      GQL.Objects.ProviderJoinedConversation.self,
      GQL.Objects.ConversationClosed.self,
      GQL.Objects.ConversationReopened.self
    ]
  )
}