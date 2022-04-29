// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  struct ProviderInConversationFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment ProviderInConversationFragment on ProviderInConversation {
        __typename
        id
        provider {
          __typename
          ...ProviderFragment
        }
        typingAt
        seenUntil
      }
      """

    public static let possibleTypes: [String] = ["ProviderInConversation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("provider", type: .nonNull(.object(Provider.selections))),
        GraphQLField("typingAt", type: .scalar(GQL.DateTime.self)),
        GraphQLField("seenUntil", type: .scalar(GQL.DateTime.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GQL.UUID, provider: Provider, typingAt: GQL.DateTime? = nil, seenUntil: GQL.DateTime? = nil) {
      self.init(unsafeResultMap: ["__typename": "ProviderInConversation", "id": id, "provider": provider.resultMap, "typingAt": typingAt, "seenUntil": seenUntil])
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

    public var provider: Provider {
      get {
        return Provider(unsafeResultMap: resultMap["provider"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "provider")
      }
    }

    public var typingAt: GQL.DateTime? {
      get {
        return resultMap["typingAt"] as? GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "typingAt")
      }
    }

    public var seenUntil: GQL.DateTime? {
      get {
        return resultMap["seenUntil"] as? GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "seenUntil")
      }
    }

    public struct Provider: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Provider"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ProviderFragment.self),
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

        public var providerFragment: ProviderFragment {
          get {
            return ProviderFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
