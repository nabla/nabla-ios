// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class ConversationEventsSubscription: GraphQLSubscription {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      subscription ConversationEvents($id: UUID!) {
        conversation(id: $id) {
          __typename
          event {
            __typename
            ... on SubscriptionReadinessEvent {
              __typename
              isReady
            }
            ... on MessageCreatedEvent {
              __typename
              message {
                __typename
                ...MessageFragment
              }
            }
            ... on MessageUpdatedEvent {
              __typename
              message {
                __typename
                ...MessageFragment
              }
            }
            ... on TypingEvent {
              __typename
              provider {
                __typename
                ...ProviderInConversationFragment
              }
            }
            ... on ConversationActivityCreated {
              __typename
              activity {
                __typename
                ...ConversationActivityFragment
              }
            }
          }
        }
      }
      """

     let operationName: String = "ConversationEvents"

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
      document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
      document.append("\n" + ConversationActivityFragment.fragmentDefinition)
      document.append("\n" + MaybeProviderFragment.fragmentDefinition)
      return document
    }

     var id: GQL.UUID

     init(id: GQL.UUID) {
      self.id = id
    }

     var variables: GraphQLMap? {
      return ["id": id]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Subscription"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("conversation", arguments: ["id": GraphQLVariable("id")], type: .object(Conversation.selections)),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(conversation: Conversation? = nil) {
        self.init(unsafeResultMap: ["__typename": "Subscription", "conversation": conversation.flatMap { (value: Conversation) -> ResultMap in value.resultMap }])
      }

       var conversation: Conversation? {
        get {
          return (resultMap["conversation"] as? ResultMap).flatMap { Conversation(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "conversation")
        }
      }

       struct Conversation: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["ConversationEventOutput"]

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
          self.init(unsafeResultMap: ["__typename": "ConversationEventOutput", "event": event.resultMap])
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
           static let possibleTypes: [String] = ["SubscriptionReadinessEvent", "ConversationActivityCreated", "MessageCreatedEvent", "MessageUpdatedEvent", "TypingEvent"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLTypeCase(
                variants: ["SubscriptionReadinessEvent": AsSubscriptionReadinessEvent.selections, "MessageCreatedEvent": AsMessageCreatedEvent.selections, "MessageUpdatedEvent": AsMessageUpdatedEvent.selections, "TypingEvent": AsTypingEvent.selections, "ConversationActivityCreated": AsConversationActivityCreated.selections],
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

           static func makeMessageCreatedEvent(message: AsMessageCreatedEvent.Message) -> Event {
            return Event(unsafeResultMap: ["__typename": "MessageCreatedEvent", "message": message.resultMap])
          }

           static func makeMessageUpdatedEvent(message: AsMessageUpdatedEvent.Message) -> Event {
            return Event(unsafeResultMap: ["__typename": "MessageUpdatedEvent", "message": message.resultMap])
          }

           static func makeTypingEvent(provider: AsTypingEvent.Provider) -> Event {
            return Event(unsafeResultMap: ["__typename": "TypingEvent", "provider": provider.resultMap])
          }

           static func makeConversationActivityCreated(activity: AsConversationActivityCreated.Activity) -> Event {
            return Event(unsafeResultMap: ["__typename": "ConversationActivityCreated", "activity": activity.resultMap])
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

           var asMessageCreatedEvent: AsMessageCreatedEvent? {
            get {
              if !AsMessageCreatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsMessageCreatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsMessageCreatedEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["MessageCreatedEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("message", type: .nonNull(.object(Message.selections))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(message: Message) {
              self.init(unsafeResultMap: ["__typename": "MessageCreatedEvent", "message": message.resultMap])
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

           var asMessageUpdatedEvent: AsMessageUpdatedEvent? {
            get {
              if !AsMessageUpdatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsMessageUpdatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsMessageUpdatedEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["MessageUpdatedEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("message", type: .nonNull(.object(Message.selections))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(message: Message) {
              self.init(unsafeResultMap: ["__typename": "MessageUpdatedEvent", "message": message.resultMap])
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

           var asTypingEvent: AsTypingEvent? {
            get {
              if !AsTypingEvent.possibleTypes.contains(__typename) { return nil }
              return AsTypingEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsTypingEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["TypingEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("provider", type: .nonNull(.object(Provider.selections))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(provider: Provider) {
              self.init(unsafeResultMap: ["__typename": "TypingEvent", "provider": provider.resultMap])
            }

             var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

             var provider: Provider {
              get {
                return Provider(unsafeResultMap: resultMap["provider"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "provider")
              }
            }

             struct Provider: GraphQLSelectionSet {
               static let possibleTypes: [String] = ["ProviderInConversation"]

               static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(ProviderInConversationFragment.self),
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

                 var providerInConversationFragment: ProviderInConversationFragment {
                  get {
                    return ProviderInConversationFragment(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }
            }
          }

           var asConversationActivityCreated: AsConversationActivityCreated? {
            get {
              if !AsConversationActivityCreated.possibleTypes.contains(__typename) { return nil }
              return AsConversationActivityCreated(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsConversationActivityCreated: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["ConversationActivityCreated"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("activity", type: .nonNull(.object(Activity.selections))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(activity: Activity) {
              self.init(unsafeResultMap: ["__typename": "ConversationActivityCreated", "activity": activity.resultMap])
            }

             var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

             var activity: Activity {
              get {
                return Activity(unsafeResultMap: resultMap["activity"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "activity")
              }
            }

             struct Activity: GraphQLSelectionSet {
               static let possibleTypes: [String] = ["ConversationActivity"]

               static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(ConversationActivityFragment.self),
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

                 var conversationActivityFragment: ConversationActivityFragment {
                  get {
                    return ConversationActivityFragment(unsafeResultMap: resultMap)
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
}
