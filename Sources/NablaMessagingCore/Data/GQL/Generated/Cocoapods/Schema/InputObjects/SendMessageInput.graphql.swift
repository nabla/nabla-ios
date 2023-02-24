// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension GQL {
  struct SendMessageInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      content: SendMessageContentInput,
      clientId: UUID,
      replyToMessageId: GraphQLNullable<UUID> = nil
    ) {
      __data = InputDict([
        "content": content,
        "clientId": clientId,
        "replyToMessageId": replyToMessageId
      ])
    }

    var content: SendMessageContentInput {
      get { __data["content"] }
      set { __data["content"] = newValue }
    }

    var clientId: UUID {
      get { __data["clientId"] }
      set { __data["clientId"] = newValue }
    }

    var replyToMessageId: GraphQLNullable<UUID> {
      get { __data["replyToMessageId"] }
      set { __data["replyToMessageId"] = newValue }
    }
  }

}