// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class GetConversationsQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      query GetConversations($page: OpaqueCursorPage!) {
        conversations(page: $page) {
          __typename
          conversations {
            __typename
            ...ConversationFragment
          }
          nextCursor
          hasMore
        }
      }
      """

     let operationName: String = "GetConversations"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      return document
    }

     var page: OpaqueCursorPage

     init(page: OpaqueCursorPage) {
      self.page = page
    }

     var variables: GraphQLMap? {
      return ["page": page]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Query"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("conversations", arguments: ["page": GraphQLVariable("page")], type: .nonNull(.object(Conversation.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(conversations: Conversation) {
        self.init(unsafeResultMap: ["__typename": "Query", "conversations": conversations.resultMap])
      }

       var conversations: Conversation {
        get {
          return Conversation(unsafeResultMap: resultMap["conversations"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "conversations")
        }
      }

       struct Conversation: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["ConversationsOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("conversations", type: .nonNull(.list(.nonNull(.object(Conversation.selections))))),
            GraphQLField("nextCursor", type: .scalar(String.self)),
            GraphQLField("hasMore", type: .nonNull(.scalar(Bool.self))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(conversations: [Conversation], nextCursor: String? = nil, hasMore: Bool) {
          self.init(unsafeResultMap: ["__typename": "ConversationsOutput", "conversations": conversations.map { (value: Conversation) -> ResultMap in value.resultMap }, "nextCursor": nextCursor, "hasMore": hasMore])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var conversations: [Conversation] {
          get {
            return (resultMap["conversations"] as! [ResultMap]).map { (value: ResultMap) -> Conversation in Conversation(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Conversation) -> ResultMap in value.resultMap }, forKey: "conversations")
          }
        }

         var nextCursor: String? {
          get {
            return resultMap["nextCursor"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "nextCursor")
          }
        }

         var hasMore: Bool {
          get {
            return resultMap["hasMore"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasMore")
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
