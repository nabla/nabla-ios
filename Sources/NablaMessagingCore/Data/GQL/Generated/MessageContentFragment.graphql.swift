// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  struct MessageContentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment MessageContentFragment on MessageContent {
        __typename
        ... on TextMessageContent {
          __typename
          ...TextMessageContentFragment
        }
        ... on ImageMessageContent {
          __typename
          ...ImageMessageContentFragment
        }
        ... on DocumentMessageContent {
          __typename
          ...DocumentMessageContentFragment
        }
        ... on DeletedMessageContent {
          __typename
          empty: _
        }
      }
      """

    public static let possibleTypes: [String] = ["TextMessageContent", "ImageMessageContent", "DocumentMessageContent", "DeletedMessageContent"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLTypeCase(
          variants: ["TextMessageContent": AsTextMessageContent.selections, "ImageMessageContent": AsImageMessageContent.selections, "DocumentMessageContent": AsDocumentMessageContent.selections, "DeletedMessageContent": AsDeletedMessageContent.selections],
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

    public static func makeTextMessageContent(text: String) -> MessageContentFragment {
      return MessageContentFragment(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
    }

    public static func makeDeletedMessageContent(empty: EmptyObject) -> MessageContentFragment {
      return MessageContentFragment(unsafeResultMap: ["__typename": "DeletedMessageContent", "empty": empty])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var asTextMessageContent: AsTextMessageContent? {
      get {
        if !AsTextMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsTextMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

    public struct AsTextMessageContent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TextMessageContent"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(TextMessageContentFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(text: String) {
        self.init(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
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

        public var textMessageContentFragment: TextMessageContentFragment {
          get {
            return TextMessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

    public var asImageMessageContent: AsImageMessageContent? {
      get {
        if !AsImageMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsImageMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

    public struct AsImageMessageContent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ImageMessageContent"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ImageMessageContentFragment.self),
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

        public var imageMessageContentFragment: ImageMessageContentFragment {
          get {
            return ImageMessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

    public var asDocumentMessageContent: AsDocumentMessageContent? {
      get {
        if !AsDocumentMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsDocumentMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

    public struct AsDocumentMessageContent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["DocumentMessageContent"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(DocumentMessageContentFragment.self),
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

        public var documentMessageContentFragment: DocumentMessageContentFragment {
          get {
            return DocumentMessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

    public var asDeletedMessageContent: AsDeletedMessageContent? {
      get {
        if !AsDeletedMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsDeletedMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

    public struct AsDeletedMessageContent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["DeletedMessageContent"]

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
        self.init(unsafeResultMap: ["__typename": "DeletedMessageContent", "empty": empty])
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
