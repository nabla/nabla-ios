import Apollo
import Foundation

/// GQL namespace
public extension GQL {
    final class GetConversationQuery: GraphQLQuery {
        /// The raw GraphQL definition of this operation.
        public let operationDefinition: String =
            """
            query GetConversation($id: UUID!) {
              conversation(id: $id) {
                __typename
                conversation {
                  __typename
                  ...ConversationFragment
                }
              }
            }
            """

        public let operationName: String = "GetConversation"

        public var queryDocument: String {
            var document: String = operationDefinition
            document.append("\n" + ConversationFragment.fragmentDefinition)
            document.append("\n" + ProviderInConversationFragment.fragmentDefinition)
            document.append("\n" + ProviderFragment.fragmentDefinition)
            document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
            return document
        }

        public var id: GQL.UUID

        public init(id: GQL.UUID) {
            self.id = id
        }

        public var variables: GraphQLMap? {
            ["id": id]
        }

        public struct Data: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Query"]

            public static var selections: [GraphQLSelection] {
                [
                    GraphQLField("conversation", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.object(Conversation.selections))),
                ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
                resultMap = unsafeResultMap
            }

            public init(conversation: Conversation) {
                self.init(unsafeResultMap: ["__typename": "Query", "conversation": conversation.resultMap])
            }

            public var conversation: Conversation {
                get {
                    Conversation(unsafeResultMap: resultMap["conversation"]! as! ResultMap)
                }
                set {
                    resultMap.updateValue(newValue.resultMap, forKey: "conversation")
                }
            }

            public struct Conversation: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["ConversationOutput"]

                public static var selections: [GraphQLSelection] {
                    [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("conversation", type: .nonNull(.object(Conversation.selections))),
                    ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                    resultMap = unsafeResultMap
                }

                public init(conversation: Conversation) {
                    self.init(unsafeResultMap: ["__typename": "ConversationOutput", "conversation": conversation.resultMap])
                }

                public var __typename: String {
                    get {
                        resultMap["__typename"]! as! String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                    }
                }

                public var conversation: Conversation {
                    get {
                        Conversation(unsafeResultMap: resultMap["conversation"]! as! ResultMap)
                    }
                    set {
                        resultMap.updateValue(newValue.resultMap, forKey: "conversation")
                    }
                }

                public struct Conversation: GraphQLSelectionSet {
                    public static let possibleTypes: [String] = ["Conversation"]

                    public static var selections: [GraphQLSelection] {
                        [
                            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                            GraphQLFragmentSpread(ConversationFragment.self),
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

                        public var conversationFragment: ConversationFragment {
                            get {
                                ConversationFragment(unsafeResultMap: resultMap)
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
