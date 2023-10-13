// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct MessageAuthorFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
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

     static let possibleTypes: [String] = ["System", "Patient", "Provider", "DeletedProvider"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLTypeCase(
          variants: ["Provider": AsProvider.selections, "Patient": AsPatient.selections, "System": AsSystem.selections, "DeletedProvider": AsDeletedProvider.selections],
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

     static func makePatient(id: GQL.UUID, isMe: Bool, displayName: String) -> MessageAuthorFragment {
      return MessageAuthorFragment(unsafeResultMap: ["__typename": "Patient", "id": id, "isMe": isMe, "displayName": displayName])
    }

     static func makeDeletedProvider(empty: EmptyObject? = nil) -> MessageAuthorFragment {
      return MessageAuthorFragment(unsafeResultMap: ["__typename": "DeletedProvider", "empty": empty])
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

     var asPatient: AsPatient? {
      get {
        if !AsPatient.possibleTypes.contains(__typename) { return nil }
        return AsPatient(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsPatient: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Patient"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(PatientFragment.self),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(id: GQL.UUID, isMe: Bool, displayName: String) {
        self.init(unsafeResultMap: ["__typename": "Patient", "id": id, "isMe": isMe, "displayName": displayName])
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

         var patientFragment: PatientFragment {
          get {
            return PatientFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     var asSystem: AsSystem? {
      get {
        if !AsSystem.possibleTypes.contains(__typename) { return nil }
        return AsSystem(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsSystem: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["System"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(SystemMessageFragment.self),
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

         var systemMessageFragment: SystemMessageFragment {
          get {
            return SystemMessageFragment(unsafeResultMap: resultMap)
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
          GraphQLField("_", alias: "empty", type: .scalar(EmptyObject.self)),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(empty: EmptyObject? = nil) {
        self.init(unsafeResultMap: ["__typename": "DeletedProvider", "empty": empty])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var empty: EmptyObject? {
        get {
          return resultMap["empty"] as? EmptyObject
        }
        set {
          resultMap.updateValue(newValue, forKey: "empty")
        }
      }
    }
  }
}
