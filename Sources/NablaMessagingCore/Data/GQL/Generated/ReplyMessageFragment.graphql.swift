// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct ReplyMessageFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment ReplyMessageFragment on Message {
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
      }
      """

     static let possibleTypes: [String] = ["Message"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("clientId", type: .scalar(GQL.UUID.self)),
        GraphQLField("createdAt", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("author", type: .nonNull(.object(Author.selections))),
        GraphQLField("content", type: .nonNull(.object(Content.selections))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(id: GQL.UUID, clientId: GQL.UUID? = nil, createdAt: GQL.DateTime, author: Author, content: Content) {
      self.init(unsafeResultMap: ["__typename": "Message", "id": id, "clientId": clientId, "createdAt": createdAt, "author": author.resultMap, "content": content.resultMap])
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

     var clientId: GQL.UUID? {
      get {
        return resultMap["clientId"] as? GQL.UUID
      }
      set {
        resultMap.updateValue(newValue, forKey: "clientId")
      }
    }

     var createdAt: GQL.DateTime {
      get {
        return resultMap["createdAt"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "createdAt")
      }
    }

     var author: Author {
      get {
        return Author(unsafeResultMap: resultMap["author"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "author")
      }
    }

     var content: Content {
      get {
        return Content(unsafeResultMap: resultMap["content"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "content")
      }
    }

     struct Author: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["System", "Patient", "Provider", "DeletedProvider"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MessageAuthorFragment.self),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       static func makePatient(id: GQL.UUID, isMe: Bool, displayName: String) -> Author {
        return Author(unsafeResultMap: ["__typename": "Patient", "id": id, "isMe": isMe, "displayName": displayName])
      }

       static func makeDeletedProvider(empty: EmptyObject? = nil) -> Author {
        return Author(unsafeResultMap: ["__typename": "DeletedProvider", "empty": empty])
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

         var messageAuthorFragment: MessageAuthorFragment {
          get {
            return MessageAuthorFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     struct Content: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["TextMessageContent", "ImageMessageContent", "VideoMessageContent", "DocumentMessageContent", "DeletedMessageContent", "AudioMessageContent", "LivekitRoomMessageContent", "QuestionsSetFormMessageContent"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MessageContentFragment.self),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       static func makeTextMessageContent(text: String) -> Content {
        return Content(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
      }

       static func makeDeletedMessageContent(empty: EmptyObject? = nil) -> Content {
        return Content(unsafeResultMap: ["__typename": "DeletedMessageContent", "empty": empty])
      }

       static func makeQuestionsSetFormMessageContent() -> Content {
        return Content(unsafeResultMap: ["__typename": "QuestionsSetFormMessageContent"])
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

         var messageContentFragment: MessageContentFragment {
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
