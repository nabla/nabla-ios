// @generated
// This file was automatically generated and should not be edited.

import Apollo

protocol GQL_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == GQL.SchemaMetadata {}

protocol GQL_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == GQL.SchemaMetadata {}

protocol GQL_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == GQL.SchemaMetadata {}

protocol GQL_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == GQL.SchemaMetadata {}

extension GQL {
  typealias ID = String

  typealias SelectionSet = GQL_SelectionSet

  typealias InlineFragment = GQL_InlineFragment

  typealias MutableSelectionSet = GQL_MutableSelectionSet

  typealias MutableInlineFragment = GQL_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Mutation": return GQL.Objects.Mutation
      case "CreateConversationOutput": return GQL.Objects.CreateConversationOutput
      case "Conversation": return GQL.Objects.Conversation
      case "Message": return GQL.Objects.Message
      case "System": return GQL.Objects.System
      case "Patient": return GQL.Objects.Patient
      case "Provider": return GQL.Objects.Provider
      case "DeletedProvider": return GQL.Objects.DeletedProvider
      case "EphemeralUrl": return GQL.Objects.EphemeralUrl
      case "ImageFileUpload": return GQL.Objects.ImageFileUpload
      case "VideoFileUpload": return GQL.Objects.VideoFileUpload
      case "DocumentFileUpload": return GQL.Objects.DocumentFileUpload
      case "AudioFileUpload": return GQL.Objects.AudioFileUpload
      case "TextMessageContent": return GQL.Objects.TextMessageContent
      case "ImageMessageContent": return GQL.Objects.ImageMessageContent
      case "VideoMessageContent": return GQL.Objects.VideoMessageContent
      case "DocumentMessageContent": return GQL.Objects.DocumentMessageContent
      case "DeletedMessageContent": return GQL.Objects.DeletedMessageContent
      case "AudioMessageContent": return GQL.Objects.AudioMessageContent
      case "LivekitRoomMessageContent": return GQL.Objects.LivekitRoomMessageContent
      case "LivekitRoom": return GQL.Objects.LivekitRoom
      case "LivekitRoomOpenStatus": return GQL.Objects.LivekitRoomOpenStatus
      case "LivekitRoomClosedStatus": return GQL.Objects.LivekitRoomClosedStatus
      case "ProviderInConversation": return GQL.Objects.ProviderInConversation
      case "SendMessageOutput": return GQL.Objects.SendMessageOutput
      case "DeleteMessageOutput": return GQL.Objects.DeleteMessageOutput
      case "SetTypingOutput": return GQL.Objects.SetTypingOutput
      case "MarkConversationAsSeenOutput": return GQL.Objects.MarkConversationAsSeenOutput
      case "Query": return GQL.Objects.Query
      case "ConversationOutput": return GQL.Objects.ConversationOutput
      case "ConversationItemsPage": return GQL.Objects.ConversationItemsPage
      case "ConversationActivity": return GQL.Objects.ConversationActivity
      case "ProviderJoinedConversation": return GQL.Objects.ProviderJoinedConversation
      case "ConversationClosed": return GQL.Objects.ConversationClosed
      case "ConversationReopened": return GQL.Objects.ConversationReopened
      case "ConversationsOutput": return GQL.Objects.ConversationsOutput
      case "Subscription": return GQL.Objects.Subscription
      case "ConversationEventOutput": return GQL.Objects.ConversationEventOutput
      case "SubscriptionReadinessEvent": return GQL.Objects.SubscriptionReadinessEvent
      case "ConversationActivityCreated": return GQL.Objects.ConversationActivityCreated
      case "MessageCreatedEvent": return GQL.Objects.MessageCreatedEvent
      case "MessageUpdatedEvent": return GQL.Objects.MessageUpdatedEvent
      case "TypingEvent": return GQL.Objects.TypingEvent
      case "ConversationsEventOutput": return GQL.Objects.ConversationsEventOutput
      case "ConversationCreatedEvent": return GQL.Objects.ConversationCreatedEvent
      case "ConversationUpdatedEvent": return GQL.Objects.ConversationUpdatedEvent
      case "ConversationDeletedEvent": return GQL.Objects.ConversationDeletedEvent
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}