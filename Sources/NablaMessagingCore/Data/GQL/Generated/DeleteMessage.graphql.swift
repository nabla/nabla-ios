// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  final class DeleteMessageMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      mutation DeleteMessage($messageId: UUID!) {
        deleteMessage(id: $messageId) {
          __typename
          message {
            __typename
            id
            content {
              __typename
              ...MessageContentFragment
            }
          }
        }
      }
      """

    public let operationName: String = "DeleteMessage"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + MessageContentFragment.fragmentDefinition)
      document.append("\n" + TextMessageContentFragment.fragmentDefinition)
      document.append("\n" + ImageMessageContentFragment.fragmentDefinition)
      document.append("\n" + VideoMessageContentFragment.fragmentDefinition)
      document.append("\n" + DocumentMessageContentFragment.fragmentDefinition)
      document.append("\n" + AudioMessageContentFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      return document
    }

    public var messageId: GQL.UUID

    public init(messageId: GQL.UUID) {
      self.messageId = messageId
    }

    public var variables: GraphQLMap? {
      return ["messageId": messageId]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Mutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("deleteMessage", arguments: ["id": GraphQLVariable("messageId")], type: .nonNull(.object(DeleteMessage.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(deleteMessage: DeleteMessage) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "deleteMessage": deleteMessage.resultMap])
      }

      public var deleteMessage: DeleteMessage {
        get {
          return DeleteMessage(unsafeResultMap: resultMap["deleteMessage"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "deleteMessage")
        }
      }

      public struct DeleteMessage: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["DeleteMessageOutput"]

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
          self.init(unsafeResultMap: ["__typename": "DeleteMessageOutput", "message": message.resultMap])
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
              GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
              GraphQLField("content", type: .nonNull(.object(Content.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GQL.UUID, content: Content) {
            self.init(unsafeResultMap: ["__typename": "Message", "id": id, "content": content.resultMap])
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

          public var content: Content {
            get {
              return Content(unsafeResultMap: resultMap["content"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "content")
            }
          }

          public struct Content: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["TextMessageContent", "ImageMessageContent", "VideoMessageContent", "DocumentMessageContent", "DeletedMessageContent", "AudioMessageContent"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(MessageContentFragment.self),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeTextMessageContent(text: String) -> Content {
              return Content(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
            }

            public static func makeDeletedMessageContent(empty: EmptyObject) -> Content {
              return Content(unsafeResultMap: ["__typename": "DeletedMessageContent", "empty": empty])
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

              public var messageContentFragment: MessageContentFragment {
                get {
                  return MessageContentFragment(unsafeResultMap: resultMap)
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
}
