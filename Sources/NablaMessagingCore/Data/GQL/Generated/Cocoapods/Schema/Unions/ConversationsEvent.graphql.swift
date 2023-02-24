// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension GQL.Unions {
  static let ConversationsEvent = Union(
    name: "ConversationsEvent",
    possibleTypes: [
      GQL.Objects.SubscriptionReadinessEvent.self,
      GQL.Objects.ConversationCreatedEvent.self,
      GQL.Objects.ConversationUpdatedEvent.self,
      GQL.Objects.ConversationDeletedEvent.self
    ]
  )
}