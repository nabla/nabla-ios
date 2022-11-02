// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class GetConversationQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      query GetConversation($id: UUID!) {
        conversation(id: $id) {
          __typename
          conversation {
            __typename
            ...ConversationFragment
          }
        }
      }
      """

     let operationName: String = "GetConversation"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ConversationFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      return document
    }

     var id: GQL.UUID

     init(id: GQL.UUID) {
      self.id = id
    }

     var variables: GraphQLMap? {
      return ["id": id]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Query"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("conversation", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.object(Conversation.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(conversation: Conversation) {
        self.init(unsafeResultMap: ["__typename": "Query", "conversation": conversation.resultMap])
      }

       var conversation: Conversation {
        get {
          return Conversation(unsafeResultMap: resultMap["conversation"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "conversation")
        }
      }

       struct Conversation: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["ConversationOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("conversation", type: .nonNull(.object(Conversation.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(conversation: Conversation) {
          self.init(unsafeResultMap: ["__typename": "ConversationOutput", "conversation": conversation.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var conversation: Conversation {
          get {
            return Conversation(unsafeResultMap: resultMap["conversation"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "conversation")
          }
        }

         struct Conversation: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["Conversation"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ConversationFragment.self),
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

           var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

           struct Fragments {
             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             var conversationFragment: ConversationFragment {
              get {
                return ConversationFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}
