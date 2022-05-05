import Apollo
import Foundation

/// GQL namespace
public extension GQL {
    struct ConversationFragment: GraphQLFragment {
        /// The raw GraphQL definition of this fragment.
        public static let fragmentDefinition: String =
            """
            fragment ConversationFragment on Conversation {
              __typename
              id
              title
              description
              lastMessagePreview
              unreadMessageCount
              inboxPreviewTitle
              updatedAt
              providers {
                __typename
                ...ProviderInConversationFragment
              }
            }
            """

        public static let possibleTypes: [String] = ["Conversation"]

        public static var selections: [GraphQLSelection] {
            [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
                GraphQLField("title", type: .scalar(String.self)),
                GraphQLField("description", type: .scalar(String.self)),
                GraphQLField("lastMessagePreview", type: .scalar(String.self)),
                GraphQLField("unreadMessageCount", type: .nonNull(.scalar(Int.self))),
                GraphQLField("inboxPreviewTitle", type: .nonNull(.scalar(String.self))),
                GraphQLField("updatedAt", type: .nonNull(.scalar(GQL.DateTime.self))),
                GraphQLField("providers", type: .nonNull(.list(.nonNull(.object(Provider.selections))))),
            ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
            resultMap = unsafeResultMap
        }

        public init(id: GQL.UUID, title: String? = nil, description: String? = nil, lastMessagePreview: String? = nil, unreadMessageCount: Int, inboxPreviewTitle: String, updatedAt: GQL.DateTime, providers: [Provider]) {
            self.init(unsafeResultMap: ["__typename": "Conversation", "id": id, "title": title, "description": description, "lastMessagePreview": lastMessagePreview, "unreadMessageCount": unreadMessageCount, "inboxPreviewTitle": inboxPreviewTitle, "updatedAt": updatedAt, "providers": providers.map { (value: Provider) -> ResultMap in value.resultMap }])
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

        public var title: String? {
            get {
                resultMap["title"] as? String
            }
            set {
                resultMap.updateValue(newValue, forKey: "title")
            }
        }

        public var description: String? {
            get {
                resultMap["description"] as? String
            }
            set {
                resultMap.updateValue(newValue, forKey: "description")
            }
        }

        public var lastMessagePreview: String? {
            get {
                resultMap["lastMessagePreview"] as? String
            }
            set {
                resultMap.updateValue(newValue, forKey: "lastMessagePreview")
            }
        }

        public var unreadMessageCount: Int {
            get {
                resultMap["unreadMessageCount"]! as! Int
            }
            set {
                resultMap.updateValue(newValue, forKey: "unreadMessageCount")
            }
        }

        public var inboxPreviewTitle: String {
            get {
                resultMap["inboxPreviewTitle"]! as! String
            }
            set {
                resultMap.updateValue(newValue, forKey: "inboxPreviewTitle")
            }
        }

        public var updatedAt: GQL.DateTime {
            get {
                resultMap["updatedAt"]! as! GQL.DateTime
            }
            set {
                resultMap.updateValue(newValue, forKey: "updatedAt")
            }
        }

        public var providers: [Provider] {
            get {
                (resultMap["providers"] as! [ResultMap]).map { (value: ResultMap) -> Provider in Provider(unsafeResultMap: value) }
            }
            set {
                resultMap.updateValue(newValue.map { (value: Provider) -> ResultMap in value.resultMap }, forKey: "providers")
            }
        }

        public struct Provider: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ProviderInConversation"]

            public static var selections: [GraphQLSelection] {
                [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLFragmentSpread(ProviderInConversationFragment.self),
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

                public var providerInConversationFragment: ProviderInConversationFragment {
                    get {
                        ProviderInConversationFragment(unsafeResultMap: resultMap)
                    }
                    set {
                        resultMap += newValue.resultMap
                    }
                }
            }
        }
    }
}
