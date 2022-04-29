// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  final class SetTypingMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      mutation SetTyping($conversationId: UUID!, $isTyping: Boolean!) {
        setTyping(conversationId: $conversationId, isTyping: $isTyping) {
          __typename
        }
      }
      """

    public let operationName: String = "SetTyping"

    public var conversationId: GQL.UUID
    public var isTyping: Bool

    public init(conversationId: GQL.UUID, isTyping: Bool) {
      self.conversationId = conversationId
      self.isTyping = isTyping
    }

    public var variables: GraphQLMap? {
      return ["conversationId": conversationId, "isTyping": isTyping]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Mutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("setTyping", arguments: ["conversationId": GraphQLVariable("conversationId"), "isTyping": GraphQLVariable("isTyping")], type: .nonNull(.object(SetTyping.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(setTyping: SetTyping) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "setTyping": setTyping.resultMap])
      }

      public var setTyping: SetTyping {
        get {
          return SetTyping(unsafeResultMap: resultMap["setTyping"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "setTyping")
        }
      }

      public struct SetTyping: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["SetTypingOutput"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init() {
          self.init(unsafeResultMap: ["__typename": "SetTypingOutput"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }
      }
    }
  }
}
