import Apollo
import Foundation

/// GQL namespace
public extension GQL {
    final class GetConversationItemsQuery: GraphQLQuery {
        /// The raw GraphQL definition of this operation.
        public let operationDefinition: String =
            """
            query GetConversationItems($id: UUID!, $page: OpaqueCursorPage!) {
              conversation(id: $id) {
                __typename
                conversation {
                  __typename
                  id
                  items(page: $page) {
                    __typename
                    hasMore
                    nextCursor
                    data {
                      __typename
                      ...ConversationItemFragment
                    }
                  }
                }
              }
            }
            """

        public let operationName: String = "GetConversationItems"

        public var queryDocument: String {
            var document: String = operationDefinition
            document.append("\n" + ConversationItemFragment.fragmentDefinition)
            document.append("\n" + MessageFragment.fragmentDefinition)
            document.append("\n" + ProviderFragment.fragmentDefinition)
            document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
            document.append("\n" + PatientFragment.fragmentDefinition)
            document.append("\n" + MessageContentFragment.fragmentDefinition)
            document.append("\n" + TextMessageContentFragment.fragmentDefinition)
            document.append("\n" + ImageMessageContentFragment.fragmentDefinition)
            document.append("\n" + DocumentMessageContentFragment.fragmentDefinition)
            return document
        }

        public var id: GQL.UUID
        public var page: OpaqueCursorPage

        public init(id: GQL.UUID, page: OpaqueCursorPage) {
            self.id = id
            self.page = page
        }

        public var variables: GraphQLMap? {
            ["id": id, "page": page]
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
                            GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
                            GraphQLField("items", arguments: ["page": GraphQLVariable("page")], type: .nonNull(.object(Item.selections))),
                        ]
                    }

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                        resultMap = unsafeResultMap
                    }

                    public init(id: GQL.UUID, items: Item) {
                        self.init(unsafeResultMap: ["__typename": "Conversation", "id": id, "items": items.resultMap])
                    }

                    public var __typename: String {
                        get {
                            resultMap["__typename"]! as! String
                        }
                        set {
                            resultMap.updateValue(newValue, forKey: "__typename")
                        }
                    }

                    public var id: GQL.UUID {
                        get {
                            resultMap["id"]! as! GQL.UUID
                        }
                        set {
                            resultMap.updateValue(newValue, forKey: "id")
                        }
                    }

                    public var items: Item {
                        get {
                            Item(unsafeResultMap: resultMap["items"]! as! ResultMap)
                        }
                        set {
                            resultMap.updateValue(newValue.resultMap, forKey: "items")
                        }
                    }

                    public struct Item: GraphQLSelectionSet {
                        public static let possibleTypes: [String] = ["ConversationItemsPage"]

                        public static var selections: [GraphQLSelection] {
                            [
                                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                                GraphQLField("hasMore", type: .nonNull(.scalar(Bool.self))),
                                GraphQLField("nextCursor", type: .scalar(String.self)),
                                GraphQLField("data", type: .nonNull(.list(.object(Datum.selections)))),
                            ]
                        }

                        public private(set) var resultMap: ResultMap

                        public init(unsafeResultMap: ResultMap) {
                            resultMap = unsafeResultMap
                        }

                        public init(hasMore: Bool, nextCursor: String? = nil, data: [Datum?]) {
                            self.init(unsafeResultMap: ["__typename": "ConversationItemsPage", "hasMore": hasMore, "nextCursor": nextCursor, "data": data.map { (value: Datum?) -> ResultMap? in value.flatMap { (value: Datum) -> ResultMap in value.resultMap } }])
                        }

                        public var __typename: String {
                            get {
                                resultMap["__typename"]! as! String
                            }
                            set {
                                resultMap.updateValue(newValue, forKey: "__typename")
                            }
                        }

                        public var hasMore: Bool {
                            get {
                                resultMap["hasMore"]! as! Bool
                            }
                            set {
                                resultMap.updateValue(newValue, forKey: "hasMore")
                            }
                        }

                        public var nextCursor: String? {
                            get {
                                resultMap["nextCursor"] as? String
                            }
                            set {
                                resultMap.updateValue(newValue, forKey: "nextCursor")
                            }
                        }

                        public var data: [Datum?] {
                            get {
                                (resultMap["data"] as! [ResultMap?]).map { (value: ResultMap?) -> Datum? in value.flatMap { (value: ResultMap) -> Datum in Datum(unsafeResultMap: value) } }
                            }
                            set {
                                resultMap.updateValue(newValue.map { (value: Datum?) -> ResultMap? in value.flatMap { (value: Datum) -> ResultMap in value.resultMap } }, forKey: "data")
                            }
                        }

                        public struct Datum: GraphQLSelectionSet {
                            public static let possibleTypes: [String] = ["Message"]

                            public static var selections: [GraphQLSelection] {
                                [
                                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                                    GraphQLFragmentSpread(ConversationItemFragment.self),
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

                                public var conversationItemFragment: ConversationItemFragment {
                                    get {
                                        ConversationItemFragment(unsafeResultMap: resultMap)
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
