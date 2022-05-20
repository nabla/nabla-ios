// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  struct ConversationActivityFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment ConversationActivityFragment on ConversationActivity {
        __typename
        id
        activityTime
        content {
          __typename
          ... on ProviderJoinedConversation {
            __typename
            provider {
              __typename
              ...MaybeProviderFragment
            }
          }
        }
      }
      """

    public static let possibleTypes: [String] = ["ConversationActivity"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("activityTime", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("content", type: .nonNull(.object(Content.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GQL.UUID, activityTime: GQL.DateTime, content: Content) {
      self.init(unsafeResultMap: ["__typename": "ConversationActivity", "id": id, "activityTime": activityTime, "content": content.resultMap])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GQL.UUID {
      get {
        return resultMap["id"]! as! GQL.UUID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var activityTime: GQL.DateTime {
      get {
        return resultMap["activityTime"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "activityTime")
      }
    }

    public var content: Content {
      get {
        return Content(unsafeResultMap: resultMap["content"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "content")
      }
    }

    public struct Content: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ProviderJoinedConversation"]

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
        self.init(unsafeResultMap: ["__typename": "ProviderJoinedConversation", "provider": provider.resultMap])
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
        public static let possibleTypes: [String] = ["Provider", "DeletedProvider"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(MaybeProviderFragment.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeDeletedProvider(`_`: EmptyObject) -> Provider {
          return Provider(unsafeResultMap: ["__typename": "DeletedProvider", "_": `_`])
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

          public var maybeProviderFragment: MaybeProviderFragment {
            get {
              return MaybeProviderFragment(unsafeResultMap: resultMap)
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
