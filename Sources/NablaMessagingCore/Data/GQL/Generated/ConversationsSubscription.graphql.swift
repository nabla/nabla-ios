// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class ConversationsEventsSubscription: GraphQLSubscription {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      subscription ConversationsEvents {
        conversations {
          __typename
          event {
            __typename
            ... on SubscriptionReadinessEvent {
              __typename
              isReady
            }
            ... on ConversationCreatedEvent {
              __typename
              conversation {
                __typename
                ...ConversationFragment
              }
            }
            ... on ConversationUpdatedEvent {
              __typename
              conversation {
                __typename
                ...ConversationFragment
              }
            }
            ... on ConversationDeletedEvent {
              __typename
              conversationId
            }
          }
        }
      }
      """

     let operationName: String = "ConversationsEvents"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ConversationFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      return document
    }

     init() {
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Subscription"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("conversations", type: .object(Conversation.selections)),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(conversations: Conversation? = nil) {
        self.init(unsafeResultMap: ["__typename": "Subscription", "conversations": conversations.flatMap { (value: Conversation) -> ResultMap in value.resultMap }])
      }

       var conversations: Conversation? {
        get {
          return (resultMap["conversations"] as? ResultMap).flatMap { Conversation(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "conversations")
        }
      }

       struct Conversation: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["ConversationsEventOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("event", type: .nonNull(.object(Event.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(event: Event) {
          self.init(unsafeResultMap: ["__typename": "ConversationsEventOutput", "event": event.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var event: Event {
          get {
            return Event(unsafeResultMap: resultMap["event"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "event")
          }
        }

         struct Event: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["SubscriptionReadinessEvent", "ConversationCreatedEvent", "ConversationUpdatedEvent", "ConversationDeletedEvent"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLTypeCase(
                variants: ["SubscriptionReadinessEvent": AsSubscriptionReadinessEvent.selections, "ConversationCreatedEvent": AsConversationCreatedEvent.selections, "ConversationUpdatedEvent": AsConversationUpdatedEvent.selections, "ConversationDeletedEvent": AsConversationDeletedEvent.selections],
                default: [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                ]
              )
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           static func makeSubscriptionReadinessEvent(isReady: Bool) -> Event {
            return Event(unsafeResultMap: ["__typename": "SubscriptionReadinessEvent", "isReady": isReady])
          }

           static func makeConversationCreatedEvent(conversation: AsConversationCreatedEvent.Conversation) -> Event {
            return Event(unsafeResultMap: ["__typename": "ConversationCreatedEvent", "conversation": conversation.resultMap])
          }

           static func makeConversationUpdatedEvent(conversation: AsConversationUpdatedEvent.Conversation) -> Event {
            return Event(unsafeResultMap: ["__typename": "ConversationUpdatedEvent", "conversation": conversation.resultMap])
          }

           static func makeConversationDeletedEvent(conversationId: GQL.UUID) -> Event {
            return Event(unsafeResultMap: ["__typename": "ConversationDeletedEvent", "conversationId": conversationId])
          }

           var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

           var asSubscriptionReadinessEvent: AsSubscriptionReadinessEvent? {
            get {
              if !AsSubscriptionReadinessEvent.possibleTypes.contains(__typename) { return nil }
              return AsSubscriptionReadinessEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsSubscriptionReadinessEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["SubscriptionReadinessEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("isReady", type: .nonNull(.scalar(Bool.self))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(isReady: Bool) {
              self.init(unsafeResultMap: ["__typename": "SubscriptionReadinessEvent", "isReady": isReady])
            }

             var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

             var isReady: Bool {
              get {
                return resultMap["isReady"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isReady")
              }
            }
          }

           var asConversationCreatedEvent: AsConversationCreatedEvent? {
            get {
              if !AsConversationCreatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsConversationCreatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsConversationCreatedEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["ConversationCreatedEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("conversation", type: .nonNull(.object(Conversation.selections))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(conversation: Conversation) {
              self.init(unsafeResultMap: ["__typename": "ConversationCreatedEvent", "conversation": conversation.resultMap])
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

           var asConversationUpdatedEvent: AsConversationUpdatedEvent? {
            get {
              if !AsConversationUpdatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsConversationUpdatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsConversationUpdatedEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["ConversationUpdatedEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("conversation", type: .nonNull(.object(Conversation.selections))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(conversation: Conversation) {
              self.init(unsafeResultMap: ["__typename": "ConversationUpdatedEvent", "conversation": conversation.resultMap])
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

           var asConversationDeletedEvent: AsConversationDeletedEvent? {
            get {
              if !AsConversationDeletedEvent.possibleTypes.contains(__typename) { return nil }
              return AsConversationDeletedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsConversationDeletedEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["ConversationDeletedEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("conversationId", type: .nonNull(.scalar(GQL.UUID.self))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(conversationId: GQL.UUID) {
              self.init(unsafeResultMap: ["__typename": "ConversationDeletedEvent", "conversationId": conversationId])
            }

             var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

             var conversationId: GQL.UUID {
              get {
                return resultMap["conversationId"]! as! GQL.UUID
              }
              set {
                resultMap.updateValue(newValue, forKey: "conversationId")
              }
            }
          }
        }
      }
    }
  }
}
