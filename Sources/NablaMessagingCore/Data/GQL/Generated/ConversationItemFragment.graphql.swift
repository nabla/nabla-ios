import Apollo
import Foundation

/// GQL namespace
public extension GQL {
    struct ConversationItemFragment: GraphQLFragment {
        /// The raw GraphQL definition of this fragment.
        public static let fragmentDefinition: String =
            """
            fragment ConversationItemFragment on ConversationItem {
              __typename
              ... on Message {
                __typename
                ...MessageFragment
              }
              ... on ConversationActivity {
                __typename
                ...ConversationActivityFragment
              }
            }
            """

        public static let possibleTypes: [String] = ["Message", "ConversationActivity"]

        public static var selections: [GraphQLSelection] {
            [
                GraphQLTypeCase(
                    variants: ["Message": AsMessage.selections, "ConversationActivity": AsConversationActivity.selections],
                    default: [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    ]
                ),
            ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
            resultMap = unsafeResultMap
        }

        public static func makeConversationActivity(id: GQL.UUID) -> ConversationItemFragment {
            ConversationItemFragment(unsafeResultMap: ["__typename": "ConversationActivity", "id": id])
        }

        public var __typename: String {
            get {
                resultMap["__typename"]! as! String
            }
            set {
                resultMap.updateValue(newValue, forKey: "__typename")
            }
        }

        public var asMessage: AsMessage? {
            get {
                if !AsMessage.possibleTypes.contains(__typename) { return nil }
                return AsMessage(unsafeResultMap: resultMap)
            }
            set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
            }
        }

        public struct AsMessage: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Message"]

            public static var selections: [GraphQLSelection] {
                [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLFragmentSpread(MessageFragment.self),
                ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
                resultMap = unsafeResultMap
            }

            public var __typename: String {
                get {
                    resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }

            public var fragments: Fragments {
                get {
                    Fragments(unsafeResultMap: resultMap)
                }
                set {
                    resultMap += newValue.resultMap
                }
            }

            public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                    resultMap = unsafeResultMap
                }

                public var messageFragment: MessageFragment {
                    get {
                        MessageFragment(unsafeResultMap: resultMap)
                    }
                    set {
                        resultMap += newValue.resultMap
                    }
                }
            }
        }

        public var asConversationActivity: AsConversationActivity? {
            get {
                if !AsConversationActivity.possibleTypes.contains(__typename) { return nil }
                return AsConversationActivity(unsafeResultMap: resultMap)
            }
            set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
            }
        }

        public struct AsConversationActivity: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ConversationActivity"]

            public static var selections: [GraphQLSelection] {
                [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLFragmentSpread(ConversationActivityFragment.self),
                ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
                resultMap = unsafeResultMap
            }

            public init(id: GQL.UUID) {
                self.init(unsafeResultMap: ["__typename": "ConversationActivity", "id": id])
            }

            public var __typename: String {
                get {
                    resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }

            public var fragments: Fragments {
                get {
                    Fragments(unsafeResultMap: resultMap)
                }
                set {
                    resultMap += newValue.resultMap
                }
            }

            public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                    resultMap = unsafeResultMap
                }

                public var conversationActivityFragment: ConversationActivityFragment {
                    get {
                        ConversationActivityFragment(unsafeResultMap: resultMap)
                    }
                    set {
                        resultMap += newValue.resultMap
                    }
                }
            }
        }
    }
}
