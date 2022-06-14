// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  struct MessageAuthorFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment MessageAuthorFragment on MessageAuthor {
        __typename
        ... on Provider {
          __typename
          ...ProviderFragment
        }
        ... on Patient {
          __typename
          ...PatientFragment
        }
        ... on System {
          __typename
          ...SystemMessageFragment
        }
        ... on DeletedProvider {
          __typename
          empty: _
        }
      }
      """

    public static let possibleTypes: [String] = ["System", "Patient", "Provider", "DeletedProvider"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLTypeCase(
          variants: ["Provider": AsProvider.selections, "Patient": AsPatient.selections, "System": AsSystem.selections, "DeletedProvider": AsDeletedProvider.selections],
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

    public static func makePatient(id: GQL.UUID) -> MessageAuthorFragment {
      return MessageAuthorFragment(unsafeResultMap: ["__typename": "Patient", "id": id])
    }

    public static func makeDeletedProvider(empty: EmptyObject) -> MessageAuthorFragment {
      return MessageAuthorFragment(unsafeResultMap: ["__typename": "DeletedProvider", "empty": empty])
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

    public var asPatient: AsPatient? {
      get {
        if !AsPatient.possibleTypes.contains(__typename) { return nil }
        return AsPatient(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

    public struct AsPatient: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Patient"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(PatientFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GQL.UUID) {
        self.init(unsafeResultMap: ["__typename": "Patient", "id": id])
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

        public var patientFragment: PatientFragment {
          get {
            return PatientFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

    public var asSystem: AsSystem? {
      get {
        if !AsSystem.possibleTypes.contains(__typename) { return nil }
        return AsSystem(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

    public struct AsSystem: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["System"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(SystemMessageFragment.self),
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

        public var systemMessageFragment: SystemMessageFragment {
          get {
            return SystemMessageFragment(unsafeResultMap: resultMap)
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
          GraphQLField("_", alias: "empty", type: .nonNull(.scalar(EmptyObject.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(empty: EmptyObject) {
        self.init(unsafeResultMap: ["__typename": "DeletedProvider", "empty": empty])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var empty: EmptyObject {
        get {
          return resultMap["empty"]! as! EmptyObject
        }
        set {
          resultMap.updateValue(newValue, forKey: "empty")
        }
      }
    }
  }
}
