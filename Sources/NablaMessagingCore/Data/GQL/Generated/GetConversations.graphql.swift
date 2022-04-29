// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  final class GetConversationsQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
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

    public let operationName: String = "GetConversations"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      return document
    }

    public var page: OpaqueCursorPage

    public init(page: OpaqueCursorPage) {
      self.page = page
    }

    public var variables: GraphQLMap? {
      return ["page": page]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("conversations", arguments: ["page": GraphQLVariable("page")], type: .nonNull(.object(Conversation.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(conversations: Conversation) {
        self.init(unsafeResultMap: ["__typename": "Query", "conversations": conversations.resultMap])
      }

      public var conversations: Conversation {
        get {
          return Conversation(unsafeResultMap: resultMap["conversations"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "conversations")
        }
      }

      public struct Conversation: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ConversationsOutput"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("conversations", type: .nonNull(.list(.nonNull(.object(Conversation.selections))))),
            GraphQLField("nextCursor", type: .scalar(String.self)),
            GraphQLField("hasMore", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(conversations: [Conversation], nextCursor: String? = nil, hasMore: Bool) {
          self.init(unsafeResultMap: ["__typename": "ConversationsOutput", "conversations": conversations.map { (value: Conversation) -> ResultMap in value.resultMap }, "nextCursor": nextCursor, "hasMore": hasMore])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var conversations: [Conversation] {
          get {
            return (resultMap["conversations"] as! [ResultMap]).map { (value: ResultMap) -> Conversation in Conversation(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Conversation) -> ResultMap in value.resultMap }, forKey: "conversations")
          }
        }

        public var nextCursor: String? {
          get {
            return resultMap["nextCursor"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "nextCursor")
          }
        }

        public var hasMore: Bool {
          get {
            return resultMap["hasMore"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasMore")
          }
        }

        public struct Conversation: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Conversation"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ConversationFragment.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var conversationFragment: ConversationFragment {
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
