// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class SetTypingMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      mutation SetTyping($conversationId: UUID!, $isTyping: Boolean!) {
        setTyping(conversationId: $conversationId, isTyping: $isTyping) {
          __typename
        }
      }
      """

     let operationName: String = "SetTyping"

     var conversationId: GQL.UUID
     var isTyping: Bool

     init(conversationId: GQL.UUID, isTyping: Bool) {
      self.conversationId = conversationId
      self.isTyping = isTyping
    }

     var variables: GraphQLMap? {
      return ["conversationId": conversationId, "isTyping": isTyping]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Mutation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("setTyping", arguments: ["conversationId": GraphQLVariable("conversationId"), "isTyping": GraphQLVariable("isTyping")], type: .nonNull(.object(SetTyping.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(setTyping: SetTyping) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "setTyping": setTyping.resultMap])
      }

       var setTyping: SetTyping {
        get {
          return SetTyping(unsafeResultMap: resultMap["setTyping"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "setTyping")
        }
      }

       struct SetTyping: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["SetTypingOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init() {
          self.init(unsafeResultMap: ["__typename": "SetTypingOutput"])
        }

         var __typename: String {
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
