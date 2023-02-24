// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GQL.Unions {
  static let ConversationEvent = Union(
    name: "ConversationEvent",
    possibleTypes: [
      GQL.Objects.SubscriptionReadinessEvent.self,
      GQL.Objects.ConversationActivityCreated.self,
      GQL.Objects.MessageCreatedEvent.self,
      GQL.Objects.MessageUpdatedEvent.self,
      GQL.Objects.TypingEvent.self
    ]
  )
}