// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct TextMessageContentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment TextMessageContentFragment on TextMessageContent {
        __typename
        text
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.TextMessageContent }
    static var __selections: [Apollo.Selection] { [
      .field("text", String.self),
    ] }

    var text: String { __data["text"] }
  }

}