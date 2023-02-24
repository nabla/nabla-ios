// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension GQL {
  struct OpaqueCursorPage: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      cursor: GraphQLNullable<String> = nil,
      numberOfItems: GraphQLNullable<Int> = nil
    ) {
      __data = InputDict([
        "cursor": cursor,
        "numberOfItems": numberOfItems
      ])
    }

    var cursor: GraphQLNullable<String> {
      get { __data["cursor"] }
      set { __data["cursor"] = newValue }
    }

    var numberOfItems: GraphQLNullable<Int> {
      get { __data["numberOfItems"] }
      set { __data["numberOfItems"] = newValue }
    }
  }

}