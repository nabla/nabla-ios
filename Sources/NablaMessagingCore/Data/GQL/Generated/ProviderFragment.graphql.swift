// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct ProviderFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
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

     static let possibleTypes: [String] = ["Provider"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("avatarUrl", type: .object(AvatarUrl.selections)),
        GraphQLField("prefix", type: .scalar(String.self)),
        GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
        GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(id: GQL.UUID, avatarUrl: AvatarUrl? = nil, `prefix`: String? = nil, firstName: String, lastName: String) {
      self.init(unsafeResultMap: ["__typename": "Provider", "id": id, "avatarUrl": avatarUrl.flatMap { (value: AvatarUrl) -> ResultMap in value.resultMap }, "prefix": `prefix`, "firstName": firstName, "lastName": lastName])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var id: GQL.UUID {
      get {
        return resultMap["id"]! as! GQL.UUID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

     var avatarUrl: AvatarUrl? {
      get {
        return (resultMap["avatarUrl"] as? ResultMap).flatMap { AvatarUrl(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "avatarUrl")
      }
    }

     var `prefix`: String? {
      get {
        return resultMap["prefix"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "prefix")
      }
    }

     var firstName: String {
      get {
        return resultMap["firstName"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "firstName")
      }
    }

     var lastName: String {
      get {
        return resultMap["lastName"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "lastName")
      }
    }

     struct AvatarUrl: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["EphemeralUrl"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(EphemeralUrlFragment.self),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(expiresAt: GQL.DateTime, url: String) {
        self.init(unsafeResultMap: ["__typename": "EphemeralUrl", "expiresAt": expiresAt, "url": url])
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

         var ephemeralUrlFragment: EphemeralUrlFragment {
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
     static let fragmentDefinition: String =
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

     static let possibleTypes: [String] = ["Provider", "DeletedProvider"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLTypeCase(
          variants: ["Provider": AsProvider.selections, "DeletedProvider": AsDeletedProvider.selections],
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

     static func makeDeletedProvider(`_`: EmptyObject) -> MaybeProviderFragment {
      return MaybeProviderFragment(unsafeResultMap: ["__typename": "DeletedProvider", "_": `_`])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var asProvider: AsProvider? {
      get {
        if !AsProvider.possibleTypes.contains(__typename) { return nil }
        return AsProvider(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsProvider: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Provider"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ProviderFragment.self),
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

         var providerFragment: ProviderFragment {
          get {
            return ProviderFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     var asDeletedProvider: AsDeletedProvider? {
      get {
        if !AsDeletedProvider.possibleTypes.contains(__typename) { return nil }
        return AsDeletedProvider(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsDeletedProvider: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["DeletedProvider"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_", type: .nonNull(.scalar(EmptyObject.self))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(`_`: EmptyObject) {
        self.init(unsafeResultMap: ["__typename": "DeletedProvider", "_": `_`])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var `_`: EmptyObject {
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
