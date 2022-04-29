// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  final class ConversationsEventsSubscription: GraphQLSubscription {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
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

    public let operationName: String = "ConversationsEvents"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      return document
    }

    public init() {
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Subscription"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("conversations", type: .object(Conversation.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(conversations: Conversation? = nil) {
        self.init(unsafeResultMap: ["__typename": "Subscription", "conversations": conversations.flatMap { (value: Conversation) -> ResultMap in value.resultMap }])
      }

      public var conversations: Conversation? {
        get {
          return (resultMap["conversations"] as? ResultMap).flatMap { Conversation(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "conversations")
        }
      }

      public struct Conversation: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ConversationsEventOutput"]

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
          self.init(unsafeResultMap: ["__typename": "ConversationsEventOutput", "event": event.resultMap])
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
          public static let possibleTypes: [String] = ["SubscriptionReadinessEvent", "ConversationCreatedEvent", "ConversationUpdatedEvent", "ConversationDeletedEvent"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLTypeCase(
                variants: ["SubscriptionReadinessEvent": AsSubscriptionReadinessEvent.selections, "ConversationCreatedEvent": AsConversationCreatedEvent.selections, "ConversationUpdatedEvent": AsConversationUpdatedEvent.selections, "ConversationDeletedEvent": AsConversationDeletedEvent.selections],
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

          public static func makeConversationCreatedEvent(conversation: AsConversationCreatedEvent.Conversation) -> Event {
            return Event(unsafeResultMap: ["__typename": "ConversationCreatedEvent", "conversation": conversation.resultMap])
          }

          public static func makeConversationUpdatedEvent(conversation: AsConversationUpdatedEvent.Conversation) -> Event {
            return Event(unsafeResultMap: ["__typename": "ConversationUpdatedEvent", "conversation": conversation.resultMap])
          }

          public static func makeConversationDeletedEvent(conversationId: GQL.UUID) -> Event {
            return Event(unsafeResultMap: ["__typename": "ConversationDeletedEvent", "conversationId": conversationId])
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

          public var asConversationCreatedEvent: AsConversationCreatedEvent? {
            get {
              if !AsConversationCreatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsConversationCreatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsConversationCreatedEvent: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ConversationCreatedEvent"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("conversation", type: .nonNull(.object(Conversation.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(conversation: Conversation) {
              self.init(unsafeResultMap: ["__typename": "ConversationCreatedEvent", "conversation": conversation.resultMap])
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

          public var asConversationUpdatedEvent: AsConversationUpdatedEvent? {
            get {
              if !AsConversationUpdatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsConversationUpdatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsConversationUpdatedEvent: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ConversationUpdatedEvent"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("conversation", type: .nonNull(.object(Conversation.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(conversation: Conversation) {
              self.init(unsafeResultMap: ["__typename": "ConversationUpdatedEvent", "conversation": conversation.resultMap])
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

          public var asConversationDeletedEvent: AsConversationDeletedEvent? {
            get {
              if !AsConversationDeletedEvent.possibleTypes.contains(__typename) { return nil }
              return AsConversationDeletedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

          public struct AsConversationDeletedEvent: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ConversationDeletedEvent"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("conversationId", type: .nonNull(.scalar(GQL.UUID.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(conversationId: GQL.UUID) {
              self.init(unsafeResultMap: ["__typename": "ConversationDeletedEvent", "conversationId": conversationId])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var conversationId: GQL.UUID {
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
