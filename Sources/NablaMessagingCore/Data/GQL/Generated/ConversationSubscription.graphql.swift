// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  final class ConversationEventsSubscription: GraphQLSubscription {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
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

    public let operationName: String = "ConversationEvents"

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
      document.append("\n" + AudioMessageContentFragment.fragmentDefinition)
      document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
      document.append("\n" + ConversationActivityFragment.fragmentDefinition)
      document.append("\n" + MaybeProviderFragment.fragmentDefinition)
      return document
    }

    public var id: GQL.UUID

    public init(id: GQL.UUID) {
      self.id = id
    }

    public var variables: GraphQLMap? {
      return ["id": id]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Subscription"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("conversation", arguments: ["id": GraphQLVariable("id")], type: .object(Conversation.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(conversation: Conversation? = nil) {
        self.init(unsafeResultMap: ["__typename": "Subscription", "conversation": conversation.flatMap { (value: Conversation) -> ResultMap in value.resultMap }])
      }

      public var conversation: Conversation? {
        get {
          return (resultMap["conversation"] as? ResultMap).flatMap { Conversation(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "conversation")
        }
      }

      public struct Conversation: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ConversationEventOutput"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("event", type: .nonNull(.object(Event.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(event: Event) {
          self.init(unsafeResultMap: ["__typename": "ConversationEventOutput", "event": event.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var event: Event {
          get {
            return Event(unsafeResultMap: resultMap["event"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "event")
          }
        }

        public struct Event: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["SubscriptionReadinessEvent", "ConversationActivityCreated", "MessageCreatedEvent", "MessageUpdatedEvent", "TypingEvent"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLTypeCase(
                variants: ["SubscriptionReadinessEvent": AsSubscriptionReadinessEvent.selections, "MessageCreatedEvent": AsMessageCreatedEvent.selections, "MessageUpdatedEvent": AsMessageUpdatedEvent.selections, "TypingEvent": AsTypingEvent.selections, "ConversationActivityCreated": AsConversationActivityCreated.selections],
                default: [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                ]
              )
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public static func makeSubscriptionReadinessEvent(isReady: Bool) -> Event {
            return Event(unsafeResultMap: ["__typename": "SubscriptionReadinessEvent", "isReady": isReady])
          }

          public static func makeMessageCreatedEvent(message: AsMessageCreatedEvent.Message) -> Event {
            return Event(unsafeResultMap: ["__typename": "MessageCreatedEvent", "message": message.resultMap])
          }

          public static func makeMessageUpdatedEvent(message: AsMessageUpdatedEvent.Message) -> Event {
            return Event(unsafeResultMap: ["__typename": "MessageUpdatedEvent", "message": message.resultMap])
          }

          public static func makeTypingEvent(provider: AsTypingEvent.Provider) -> Event {
            return Event(unsafeResultMap: ["__typename": "TypingEvent", "provider": provider.resultMap])
          }

          public static func makeConversationActivityCreated(activity: AsConversationActivityCreated.Activity) -> Event {
            return Event(unsafeResultMap: ["__typename": "ConversationActivityCreated", "activity": activity.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var asSubscriptionReadinessEvent: AsSubscriptionReadinessEvent? {
            get {
              if !AsSubscriptionReadinessEvent.possibleTypes.contains(__typename) { return nil }
              return AsSubscriptionReadinessEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsSubscriptionReadinessEvent: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["SubscriptionReadinessEvent"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("isReady", type: .nonNull(.scalar(Bool.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(isReady: Bool) {
              self.init(unsafeResultMap: ["__typename": "SubscriptionReadinessEvent", "isReady": isReady])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var isReady: Bool {
              get {
                return resultMap["isReady"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isReady")
              }
            }
          }

          public var asMessageCreatedEvent: AsMessageCreatedEvent? {
            get {
              if !AsMessageCreatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsMessageCreatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsMessageCreatedEvent: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["MessageCreatedEvent"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("message", type: .nonNull(.object(Message.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(message: Message) {
              self.init(unsafeResultMap: ["__typename": "MessageCreatedEvent", "message": message.resultMap])
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

          public var asMessageUpdatedEvent: AsMessageUpdatedEvent? {
            get {
              if !AsMessageUpdatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsMessageUpdatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsMessageUpdatedEvent: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["MessageUpdatedEvent"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("message", type: .nonNull(.object(Message.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(message: Message) {
              self.init(unsafeResultMap: ["__typename": "MessageUpdatedEvent", "message": message.resultMap])
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

          public var asTypingEvent: AsTypingEvent? {
            get {
              if !AsTypingEvent.possibleTypes.contains(__typename) { return nil }
              return AsTypingEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsTypingEvent: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["TypingEvent"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("provider", type: .nonNull(.object(Provider.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(provider: Provider) {
              self.init(unsafeResultMap: ["__typename": "TypingEvent", "provider": provider.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var provider: Provider {
              get {
                return Provider(unsafeResultMap: resultMap["provider"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "provider")
              }
            }

            public struct Provider: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["ProviderInConversation"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(ProviderInConversationFragment.self),
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

                public var providerInConversationFragment: ProviderInConversationFragment {
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

          public var asConversationActivityCreated: AsConversationActivityCreated? {
            get {
              if !AsConversationActivityCreated.possibleTypes.contains(__typename) { return nil }
              return AsConversationActivityCreated(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsConversationActivityCreated: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ConversationActivityCreated"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("activity", type: .nonNull(.object(Activity.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(activity: Activity) {
              self.init(unsafeResultMap: ["__typename": "ConversationActivityCreated", "activity": activity.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var activity: Activity {
              get {
                return Activity(unsafeResultMap: resultMap["activity"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "activity")
              }
            }

            public struct Activity: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["ConversationActivity"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(ConversationActivityFragment.self),
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

                public var conversationActivityFragment: ConversationActivityFragment {
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
