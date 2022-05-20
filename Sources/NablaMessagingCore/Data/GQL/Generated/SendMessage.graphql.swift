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
      mutation SendMessage($conversationId: UUID!, $content: SendMessageContentInput!, $clientId: UUID!) {
        sendMessage(
          conversationId: $conversationId
          content: $content
          clientId: $clientId
        ) {
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
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      document.append("\n" + PatientFragment.fragmentDefinition)
      document.append("\n" + SystemMessageFragment.fragmentDefinition)
      document.append("\n" + MessageContentFragment.fragmentDefinition)
      document.append("\n" + TextMessageContentFragment.fragmentDefinition)
      document.append("\n" + ImageMessageContentFragment.fragmentDefinition)
      document.append("\n" + DocumentMessageContentFragment.fragmentDefinition)
      return document
    }

    public var conversationId: GQL.UUID
    public var content: SendMessageContentInput
    public var clientId: GQL.UUID

    public init(conversationId: GQL.UUID, content: SendMessageContentInput, clientId: GQL.UUID) {
      self.conversationId = conversationId
      self.content = content
      self.clientId = clientId
    }

    public var variables: GraphQLMap? {
      return ["conversationId": conversationId, "content": content, "clientId": clientId]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Mutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("sendMessage", arguments: ["conversationId": GraphQLVariable("conversationId"), "content": GraphQLVariable("content"), "clientId": GraphQLVariable("clientId")], type: .nonNull(.object(SendMessage.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(sendMessage: SendMessage) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "sendMessage": sendMessage.resultMap])
      }

      public var sendMessage: SendMessage {
        get {
          return SendMessage(unsafeResultMap: resultMap["sendMessage"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "sendMessage")
        }
      }

      public struct SendMessage: GraphQLSelectionSet {
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
