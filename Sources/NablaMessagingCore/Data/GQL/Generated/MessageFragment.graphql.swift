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
          ...MessageAuthorFragment
        }
        content {
          __typename
          ...MessageContentFragment
        }
        replyTo {
          __typename
          ...ReplyMessageFragment
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
        GraphQLField("content", type: .nonNull(.object(Content.selections))),
        GraphQLField("replyTo", type: .object(ReplyTo.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GQL.UUID, clientId: GQL.UUID? = nil, createdAt: GQL.DateTime, author: Author, content: Content, replyTo: ReplyTo? = nil) {
      self.init(unsafeResultMap: ["__typename": "Message", "id": id, "clientId": clientId, "createdAt": createdAt, "author": author.resultMap, "content": content.resultMap, "replyTo": replyTo.flatMap { (value: ReplyTo) -> ResultMap in value.resultMap }])
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

    public var content: Content {
      get {
        return Content(unsafeResultMap: resultMap["content"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "content")
      }
    }

    public var replyTo: ReplyTo? {
      get {
        return (resultMap["replyTo"] as? ResultMap).flatMap { ReplyTo(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "replyTo")
      }
    }

    public struct Author: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["System", "Patient", "Provider", "DeletedProvider"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MessageAuthorFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public static func makePatient(id: GQL.UUID) -> Author {
        return Author(unsafeResultMap: ["__typename": "Patient", "id": id])
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

        public var messageAuthorFragment: MessageAuthorFragment {
          get {
            return MessageAuthorFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

    public struct Content: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TextMessageContent", "ImageMessageContent", "VideoMessageContent", "DocumentMessageContent", "DeletedMessageContent", "AudioMessageContent"]

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

    public struct ReplyTo: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Message"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ReplyMessageFragment.self),
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

        public var replyMessageFragment: ReplyMessageFragment {
          get {
            return ReplyMessageFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
