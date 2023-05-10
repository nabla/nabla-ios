// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class SendMessageMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
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

     let operationName: String = "SendMessage"

     var queryDocument: String {
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
      document.append("\n" + LivekitRoomMessageContentFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomOpenStatusFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomClosedStatusFragment.fragmentDefinition)
      document.append("\n" + ReplyMessageFragment.fragmentDefinition)
      return document
    }

     var conversationId: GQL.UUID
     var input: SendMessageInput

     init(conversationId: GQL.UUID, input: SendMessageInput) {
      self.conversationId = conversationId
      self.input = input
    }

     var variables: GraphQLMap? {
      return ["conversationId": conversationId, "input": input]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Mutation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("sendMessageV2", arguments: ["conversationId": GraphQLVariable("conversationId"), "input": GraphQLVariable("input")], type: .nonNull(.object(SendMessageV2.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(sendMessageV2: SendMessageV2) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "sendMessageV2": sendMessageV2.resultMap])
      }

       var sendMessageV2: SendMessageV2 {
        get {
          return SendMessageV2(unsafeResultMap: resultMap["sendMessageV2"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "sendMessageV2")
        }
      }

       struct SendMessageV2: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["SendMessageOutput"]

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
          self.init(unsafeResultMap: ["__typename": "SendMessageOutput", "message": message.resultMap])
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
              GraphQLFragmentSpread(MessageFragment.self),
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

             var messageFragment: MessageFragment {
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
