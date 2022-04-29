// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  struct TextMessageContentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment TextMessageContentFragment on TextMessageContent {
        __typename
        text
      }
      """

    public static let possibleTypes: [String] = ["TextMessageContent"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("text", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(text: String) {
      self.init(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var text: String {
      get {
        return resultMap["text"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "text")
      }
    }
  }
}
