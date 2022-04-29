// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  struct MessageFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment MessageFragment on Message {
        __typename
        id
        clientId
        createdAt
        author {
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
            empty: _
          }
          ... on DeletedProvider {
            __typename
            empty: _
          }
        }
        content {
          __typename
          ...MessageContentFragment
        }
      }
      """

    public static let possibleTypes: [String] = ["Message"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("clientId", type: .scalar(GQL.UUID.self)),
        GraphQLField("createdAt", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("author", type: .nonNull(.object(Author.selections))),
        GraphQLField("content", type: .object(Content.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GQL.UUID, clientId: GQL.UUID? = nil, createdAt: GQL.DateTime, author: Author, content: Content? = nil) {
      self.init(unsafeResultMap: ["__typename": "Message", "id": id, "clientId": clientId, "createdAt": createdAt, "author": author.resultMap, "content": content.flatMap { (value: Content) -> ResultMap in value.resultMap }])
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

    public var clientId: GQL.UUID? {
      get {
        return resultMap["clientId"] as? GQL.UUID
      }
      set {
        resultMap.updateValue(newValue, forKey: "clientId")
      }
    }

    public var createdAt: GQL.DateTime {
      get {
        return resultMap["createdAt"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "createdAt")
      }
    }

    public var author: Author {
      get {
        return Author(unsafeResultMap: resultMap["author"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "author")
      }
    }

    public var content: Content? {
      get {
        return (resultMap["content"] as? ResultMap).flatMap { Content(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "content")
      }
    }

    public struct Author: GraphQLSelectionSet {
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

      public static func makePatient(id: GQL.UUID) -> Author {
        return Author(unsafeResultMap: ["__typename": "Patient", "id": id])
      }

      public static func makeSystem(empty: EmptyObject) -> Author {
        return Author(unsafeResultMap: ["__typename": "System", "empty": empty])
      }

      public static func makeDeletedProvider(empty: EmptyObject) -> Author {
        return Author(unsafeResultMap: ["__typename": "DeletedProvider", "empty": empty])
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
            GraphQLField("_", alias: "empty", type: .nonNull(.scalar(EmptyObject.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(empty: EmptyObject) {
          self.init(unsafeResultMap: ["__typename": "System", "empty": empty])
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

    public struct Content: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TextMessageContent", "ImageMessageContent", "DocumentMessageContent", "DeletedMessageContent"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MessageContentFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public static func makeTextMessageContent(text: String) -> Content {
        return Content(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
      }

      public static func makeDeletedMessageContent(empty: EmptyObject) -> Content {
        return Content(unsafeResultMap: ["__typename": "DeletedMessageContent", "empty": empty])
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

        public var messageContentFragment: MessageContentFragment {
          get {
            return MessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
