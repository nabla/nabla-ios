// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct TextMessageContentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment TextMessageContentFragment on TextMessageContent {
        __typename
        text
      }
      """

     static let possibleTypes: [String] = ["TextMessageContent"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("text", type: .nonNull(.scalar(String.self))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(text: String) {
      self.init(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var text: String {
      get {
        return resultMap["text"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "text")
      }
    }
  }
}
