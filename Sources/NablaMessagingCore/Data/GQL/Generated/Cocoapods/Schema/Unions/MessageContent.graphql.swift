// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension GQL.Unions {
  static let MessageContent = Union(
    name: "MessageContent",
    possibleTypes: [
      GQL.Objects.TextMessageContent.self,
      GQL.Objects.ImageMessageContent.self,
      GQL.Objects.VideoMessageContent.self,
      GQL.Objects.DocumentMessageContent.self,
      GQL.Objects.DeletedMessageContent.self,
      GQL.Objects.AudioMessageContent.self,
      GQL.Objects.LivekitRoomMessageContent.self
    ]
  )
}