// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class CreateConversationMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
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

     let operationName: String = "CreateConversation"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ConversationFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      return document
    }

     var title: String?
     var providerIds: [GQL.UUID]?
     var initialMessage: SendMessageInput?

     init(title: String? = nil, providerIds: [GQL.UUID]?, initialMessage: SendMessageInput? = nil) {
      self.title = title
      self.providerIds = providerIds
      self.initialMessage = initialMessage
    }

     var variables: GraphQLMap? {
      return ["title": title, "providerIds": providerIds, "initialMessage": initialMessage]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Mutation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("createConversation", arguments: ["title": GraphQLVariable("title"), "providerIds": GraphQLVariable("providerIds"), "initialMessage": GraphQLVariable("initialMessage")], type: .nonNull(.object(CreateConversation.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(createConversation: CreateConversation) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "createConversation": createConversation.resultMap])
      }

       var createConversation: CreateConversation {
        get {
          return CreateConversation(unsafeResultMap: resultMap["createConversation"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "createConversation")
        }
      }

       struct CreateConversation: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["CreateConversationOutput"]

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
          self.init(unsafeResultMap: ["__typename": "CreateConversationOutput", "conversation": conversation.resultMap])
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
