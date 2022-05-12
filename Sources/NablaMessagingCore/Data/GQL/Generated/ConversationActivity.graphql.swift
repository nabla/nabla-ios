// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  struct ConversationActivityFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment ConversationActivityFragment on ConversationActivity {
        __typename
        id
      }
      """

    public static let possibleTypes: [String] = ["ConversationActivity"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GQL.UUID) {
      self.init(unsafeResultMap: ["__typename": "ConversationActivity", "id": id])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GQL.UUID {
      get {
        return resultMap["id"]! as! GQL.UUID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }
  }
}
