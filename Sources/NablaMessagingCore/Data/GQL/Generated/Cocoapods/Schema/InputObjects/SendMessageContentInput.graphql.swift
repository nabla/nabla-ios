// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension GQL {
  struct SendMessageContentInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      textInput: GraphQLNullable<SendTextMessageInput> = nil,
      imageInput: GraphQLNullable<SendImageMessageInput> = nil,
      videoInput: GraphQLNullable<SendVideoMessageInput> = nil,
      documentInput: GraphQLNullable<SendDocumentMessageInput> = nil,
      audioInput: GraphQLNullable<SendAudioMessageInput> = nil
    ) {
      __data = InputDict([
        "textInput": textInput,
        "imageInput": imageInput,
        "videoInput": videoInput,
        "documentInput": documentInput,
        "audioInput": audioInput
      ])
    }

    var textInput: GraphQLNullable<SendTextMessageInput> {
      get { __data["textInput"] }
      set { __data["textInput"] = newValue }
    }

    var imageInput: GraphQLNullable<SendImageMessageInput> {
      get { __data["imageInput"] }
      set { __data["imageInput"] = newValue }
    }

    var videoInput: GraphQLNullable<SendVideoMessageInput> {
      get { __data["videoInput"] }
      set { __data["videoInput"] = newValue }
    }

    var documentInput: GraphQLNullable<SendDocumentMessageInput> {
      get { __data["documentInput"] }
      set { __data["documentInput"] = newValue }
    }

    var audioInput: GraphQLNullable<SendAudioMessageInput> {
      get { __data["audioInput"] }
      set { __data["audioInput"] = newValue }
    }
  }

}