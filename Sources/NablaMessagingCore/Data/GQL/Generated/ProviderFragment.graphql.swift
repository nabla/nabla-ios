// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  struct ProviderFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment ProviderFragment on Provider {
        __typename
        id
        avatarUrl {
          __typename
          ...EphemeralUrlFragment
        }
        prefix
        firstName
        lastName
      }
      """

    public static let possibleTypes: [String] = ["Provider"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("avatarUrl", type: .object(AvatarUrl.selections)),
        GraphQLField("prefix", type: .scalar(String.self)),
        GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
        GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GQL.UUID, avatarUrl: AvatarUrl? = nil, `prefix`: String? = nil, firstName: String, lastName: String) {
      self.init(unsafeResultMap: ["__typename": "Provider", "id": id, "avatarUrl": avatarUrl.flatMap { (value: AvatarUrl) -> ResultMap in value.resultMap }, "prefix": `prefix`, "firstName": firstName, "lastName": lastName])
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

    public var avatarUrl: AvatarUrl? {
      get {
        return (resultMap["avatarUrl"] as? ResultMap).flatMap { AvatarUrl(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "avatarUrl")
      }
    }

    public var `prefix`: String? {
      get {
        return resultMap["prefix"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "prefix")
      }
    }

    public var firstName: String {
      get {
        return resultMap["firstName"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "firstName")
      }
    }

    public var lastName: String {
      get {
        return resultMap["lastName"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "lastName")
      }
    }

    public struct AvatarUrl: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["EphemeralUrl"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(EphemeralUrlFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(expiresAt: GQL.DateTime, url: String) {
        self.init(unsafeResultMap: ["__typename": "EphemeralUrl", "expiresAt": expiresAt, "url": url])
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

        public var ephemeralUrlFragment: EphemeralUrlFragment {
          get {
            return EphemeralUrlFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }

  struct MaybeProviderFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment MaybeProviderFragment on MaybeProvider {
        __typename
        ... on Provider {
          __typename
          ...ProviderFragment
        }
        ... on DeletedProvider {
          __typename
          _
        }
      }
      """

    public static let possibleTypes: [String] = ["Provider", "DeletedProvider"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLTypeCase(
          variants: ["Provider": AsProvider.selections, "DeletedProvider": AsDeletedProvider.selections],
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

    public static func makeDeletedProvider(`_`: EmptyObject) -> MaybeProviderFragment {
      return MaybeProviderFragment(unsafeResultMap: ["__typename": "DeletedProvider", "_": `_`])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var asProvider: AsProvider? {
      get {
        if !AsProvider.possibleTypes.contains(__typename) { return nil }
        return AsProvider(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

    public struct AsProvider: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Provider"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
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

    public var asDeletedProvider: AsDeletedProvider? {
      get {
        if !AsDeletedProvider.possibleTypes.contains(__typename) { return nil }
        return AsDeletedProvider(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

    public struct AsDeletedProvider: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["DeletedProvider"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_", type: .nonNull(.scalar(EmptyObject.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(`_`: EmptyObject) {
        self.init(unsafeResultMap: ["__typename": "DeletedProvider", "_": `_`])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var `_`: EmptyObject {
        get {
          return resultMap["_"]! as! EmptyObject
        }
        set {
          resultMap.updateValue(newValue, forKey: "_")
        }
      }
    }
  }
}
