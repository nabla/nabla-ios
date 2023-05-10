// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class MaskAsSeenMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      mutation MaskAsSeen($conversationId: UUID!) {
        markAsSeen(conversationId: $conversationId) {
          __typename
          conversation {
            __typename
            id
            unreadMessageCount
          }
        }
      }
      """

     let operationName: String = "MaskAsSeen"

     var conversationId: GQL.UUID

     init(conversationId: GQL.UUID) {
      self.conversationId = conversationId
    }

     var variables: GraphQLMap? {
      return ["conversationId": conversationId]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Mutation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("markAsSeen", arguments: ["conversationId": GraphQLVariable("conversationId")], type: .nonNull(.object(MarkAsSeen.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(markAsSeen: MarkAsSeen) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "markAsSeen": markAsSeen.resultMap])
      }

       var markAsSeen: MarkAsSeen {
        get {
          return MarkAsSeen(unsafeResultMap: resultMap["markAsSeen"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "markAsSeen")
        }
      }

       struct MarkAsSeen: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["MarkConversationAsSeenOutput"]

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
          self.init(unsafeResultMap: ["__typename": "MarkConversationAsSeenOutput", "conversation": conversation.resultMap])
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
              GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
              GraphQLField("unreadMessageCount", type: .nonNull(.scalar(Int.self))),
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           init(id: GQL.UUID, unreadMessageCount: Int) {
            self.init(unsafeResultMap: ["__typename": "Conversation", "id": id, "unreadMessageCount": unreadMessageCount])
          }

           var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

           var id: GQL.UUID {
            get {
              return resultMap["id"]! as! GQL.UUID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

           var unreadMessageCount: Int {
            get {
              return resultMap["unreadMessageCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "unreadMessageCount")
            }
          }
        }
      }
    }
  }
}
