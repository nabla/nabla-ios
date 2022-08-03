// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  final class MaskAsSeenMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
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

    public let operationName: String = "MaskAsSeen"

    public var conversationId: GQL.UUID

    public init(conversationId: GQL.UUID) {
      self.conversationId = conversationId
    }

    public var variables: GraphQLMap? {
      return ["conversationId": conversationId]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Mutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("markAsSeen", arguments: ["conversationId": GraphQLVariable("conversationId")], type: .nonNull(.object(MarkAsSeen.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(markAsSeen: MarkAsSeen) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "markAsSeen": markAsSeen.resultMap])
      }

      public var markAsSeen: MarkAsSeen {
        get {
          return MarkAsSeen(unsafeResultMap: resultMap["markAsSeen"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "markAsSeen")
        }
      }

      public struct MarkAsSeen: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["MarkConversationAsSeenOutput"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("conversation", type: .nonNull(.object(Conversation.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(conversation: Conversation) {
          self.init(unsafeResultMap: ["__typename": "MarkConversationAsSeenOutput", "conversation": conversation.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var conversation: Conversation {
          get {
            return Conversation(unsafeResultMap: resultMap["conversation"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "conversation")
          }
        }

        public struct Conversation: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Conversation"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
              GraphQLField("unreadMessageCount", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GQL.UUID, unreadMessageCount: Int) {
            self.init(unsafeResultMap: ["__typename": "Conversation", "id": id, "unreadMessageCount": unreadMessageCount])
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

          public var unreadMessageCount: Int {
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
