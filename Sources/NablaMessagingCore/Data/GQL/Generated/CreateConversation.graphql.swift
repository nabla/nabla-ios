// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  final class CreateConversationMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      mutation CreateConversation($title: String, $providerIds: [UUID!], $initialMessage: SendMessageInput) {
        createConversation(
          title: $title
          providerIds: $providerIds
          initialMessage: $initialMessage
        ) {
          __typename
          conversation {
            __typename
            ...ConversationFragment
          }
        }
      }
      """

    public let operationName: String = "CreateConversation"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      return document
    }

    public var title: String?
    public var providerIds: [GQL.UUID]?
    public var initialMessage: SendMessageInput?

    public init(title: String? = nil, providerIds: [GQL.UUID]?, initialMessage: SendMessageInput? = nil) {
      self.title = title
      self.providerIds = providerIds
      self.initialMessage = initialMessage
    }

    public var variables: GraphQLMap? {
      return ["title": title, "providerIds": providerIds, "initialMessage": initialMessage]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Mutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("createConversation", arguments: ["title": GraphQLVariable("title"), "providerIds": GraphQLVariable("providerIds"), "initialMessage": GraphQLVariable("initialMessage")], type: .nonNull(.object(CreateConversation.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(createConversation: CreateConversation) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "createConversation": createConversation.resultMap])
      }

      public var createConversation: CreateConversation {
        get {
          return CreateConversation(unsafeResultMap: resultMap["createConversation"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "createConversation")
        }
      }

      public struct CreateConversation: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CreateConversationOutput"]

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
          self.init(unsafeResultMap: ["__typename": "CreateConversationOutput", "conversation": conversation.resultMap])
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
