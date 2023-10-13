// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class DeleteMessageMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
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

     let operationName: String = "DeleteMessage"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + MessageContentFragment.fragmentDefinition)
      document.append("\n" + TextMessageContentFragment.fragmentDefinition)
      document.append("\n" + ImageMessageContentFragment.fragmentDefinition)
      document.append("\n" + VideoMessageContentFragment.fragmentDefinition)
      document.append("\n" + DocumentMessageContentFragment.fragmentDefinition)
      document.append("\n" + AudioMessageContentFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomMessageContentFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomOpenStatusFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomClosedStatusFragment.fragmentDefinition)
      return document
    }

     var messageId: GQL.UUID

     init(messageId: GQL.UUID) {
      self.messageId = messageId
    }

     var variables: GraphQLMap? {
      return ["messageId": messageId]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Mutation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("deleteMessage", arguments: ["id": GraphQLVariable("messageId")], type: .nonNull(.object(DeleteMessage.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(deleteMessage: DeleteMessage) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "deleteMessage": deleteMessage.resultMap])
      }

       var deleteMessage: DeleteMessage {
        get {
          return DeleteMessage(unsafeResultMap: resultMap["deleteMessage"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "deleteMessage")
        }
      }

       struct DeleteMessage: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["DeleteMessageOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("message", type: .nonNull(.object(Message.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(message: Message) {
          self.init(unsafeResultMap: ["__typename": "DeleteMessageOutput", "message": message.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var message: Message {
          get {
            return Message(unsafeResultMap: resultMap["message"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "message")
          }
        }

         struct Message: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["Message"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
              GraphQLField("content", type: .nonNull(.object(Content.selections))),
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           init(id: GQL.UUID, content: Content) {
            self.init(unsafeResultMap: ["__typename": "Message", "id": id, "content": content.resultMap])
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

           var content: Content {
            get {
              return Content(unsafeResultMap: resultMap["content"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "content")
            }
          }

           struct Content: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["TextMessageContent", "ImageMessageContent", "VideoMessageContent", "DocumentMessageContent", "DeletedMessageContent", "AudioMessageContent", "LivekitRoomMessageContent", "QuestionsSetFormMessageContent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(MessageContentFragment.self),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             static func makeTextMessageContent(text: String) -> Content {
              return Content(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
            }

             static func makeDeletedMessageContent(empty: EmptyObject? = nil) -> Content {
              return Content(unsafeResultMap: ["__typename": "DeletedMessageContent", "empty": empty])
            }

             static func makeQuestionsSetFormMessageContent() -> Content {
              return Content(unsafeResultMap: ["__typename": "QuestionsSetFormMessageContent"])
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

               var messageContentFragment: MessageContentFragment {
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
