// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GQL {
  struct UploadInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      uuid: UUID
    ) {
      __data = InputDict([
        "uuid": uuid
      ])
    }

    var uuid: UUID {
      get { __data["uuid"] }
      set { __data["uuid"] = newValue }
    }
  }

}