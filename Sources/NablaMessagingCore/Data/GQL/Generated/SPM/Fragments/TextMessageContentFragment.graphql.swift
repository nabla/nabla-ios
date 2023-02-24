// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

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

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.TextMessageContent }
    static var __selections: [ApolloAPI.Selection] { [
      .field("text", String.self),
    ] }

    var text: String { __data["text"] }
  }

}