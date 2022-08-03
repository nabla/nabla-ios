// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  final class SendMessageMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      mutation SendMessage($conversationId: UUID!, $input: SendMessageInput!) {
        sendMessageV2(conversationId: $conversationId, input: $input) {
          __typename
          message {
            __typename
            ...MessageFragment
          }
        }
      }
      """

    public let operationName: String = "SendMessage"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + MessageFragment.fragmentDefinition)
      document.append("\n" + MessageAuthorFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      document.append("\n" + PatientFragment.fragmentDefinition)
      document.append("\n" + SystemMessageFragment.fragmentDefinition)
      document.append("\n" + MessageContentFragment.fragmentDefinition)
      document.append("\n" + TextMessageContentFragment.fragmentDefinition)
      document.append("\n" + ImageMessageContentFragment.fragmentDefinition)
      document.append("\n" + VideoMessageContentFragment.fragmentDefinition)
      document.append("\n" + DocumentMessageContentFragment.fragmentDefinition)
      document.append("\n" + AudioMessageContentFragment.fragmentDefinition)
      document.append("\n" + ReplyMessageFragment.fragmentDefinition)
      return document
    }

    public var conversationId: GQL.UUID
    public var input: SendMessageInput

    public init(conversationId: GQL.UUID, input: SendMessageInput) {
      self.conversationId = conversationId
      self.input = input
    }

    public var variables: GraphQLMap? {
      return ["conversationId": conversationId, "input": input]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Mutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("sendMessageV2", arguments: ["conversationId": GraphQLVariable("conversationId"), "input": GraphQLVariable("input")], type: .nonNull(.object(SendMessageV2.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(sendMessageV2: SendMessageV2) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "sendMessageV2": sendMessageV2.resultMap])
      }

      public var sendMessageV2: SendMessageV2 {
        get {
          return SendMessageV2(unsafeResultMap: resultMap["sendMessageV2"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "sendMessageV2")
        }
      }

      public struct SendMessageV2: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["SendMessageOutput"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("message", type: .nonNull(.object(Message.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(message: Message) {
          self.init(unsafeResultMap: ["__typename": "SendMessageOutput", "message": message.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var message: Message {
          get {
            return Message(unsafeResultMap: resultMap["message"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "message")
          }
        }

        public struct Message: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Message"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(MessageFragment.self),
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

            public var messageFragment: MessageFragment {
              get {
                return MessageFragment(unsafeResultMap: resultMap)
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
