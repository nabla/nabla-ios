// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension GQL {
  struct SendTextMessageInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      text: String
    ) {
      __data = InputDict([
        "text": text
      ])
    }

    var text: String {
      get { __data["text"] }
      set { __data["text"] = newValue }
    }
  }

}