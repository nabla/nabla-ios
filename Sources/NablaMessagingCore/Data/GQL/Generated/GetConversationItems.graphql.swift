// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class GetConversationItemsQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      query GetConversationItems($id: UUID!, $page: OpaqueCursorPage!) {
        conversation(id: $id) {
          __typename
          conversation {
            __typename
            id
            items(page: $page) {
              __typename
              hasMore
              nextCursor
              data {
                __typename
                ...ConversationItemFragment
              }
            }
          }
        }
      }
      """

     let operationName: String = "GetConversationItems"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ConversationItemFragment.fragmentDefinition)
      document.append("\n" + MessageFragment.fragmentDefinition)
      document.append("\n" + MessageAuthorFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + EphemeralUrlFragment.fragmentDefinition)
      document.append("\n" + PatientFragment.fragmentDefinition)
      document.append("\n" + SystemMessageFragment.fragmentDefinition)
      document.append("\n" + MessageContentFragment.fragmentDefinition)
      document.append("\n" + TextMessageContentFragment.fragmentDefinition)
      document.append("\n" + ImageMessageContentFragment.fragmentDefinition)
      document.append("\n" + VideoMessageContentFragment.fragmentDefinition)
      document.append("\n" + DocumentMessageContentFragment.fragmentDefinition)
      document.append("\n" + AudioMessageContentFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomMessageContentFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomOpenStatusFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomClosedStatusFragment.fragmentDefinition)
      document.append("\n" + ReplyMessageFragment.fragmentDefinition)
      document.append("\n" + ConversationActivityFragment.fragmentDefinition)
      document.append("\n" + MaybeProviderFragment.fragmentDefinition)
      return document
    }

     var id: GQL.UUID
     var page: OpaqueCursorPage

     init(id: GQL.UUID, page: OpaqueCursorPage) {
      self.id = id
      self.page = page
    }

     var variables: GraphQLMap? {
      return ["id": id, "page": page]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Query"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("conversation", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.object(Conversation.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(conversation: Conversation) {
        self.init(unsafeResultMap: ["__typename": "Query", "conversation": conversation.resultMap])
      }

       var conversation: Conversation {
        get {
          return Conversation(unsafeResultMap: resultMap["conversation"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "conversation")
        }
      }

       struct Conversation: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["ConversationOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("conversation", type: .nonNull(.object(Conversation.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(conversation: Conversation) {
          self.init(unsafeResultMap: ["__typename": "ConversationOutput", "conversation": conversation.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var conversation: Conversation {
          get {
            return Conversation(unsafeResultMap: resultMap["conversation"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "conversation")
          }
        }

         struct Conversation: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["Conversation"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
              GraphQLField("items", arguments: ["page": GraphQLVariable("page")], type: .nonNull(.object(Item.selections))),
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           init(id: GQL.UUID, items: Item) {
            self.init(unsafeResultMap: ["__typename": "Conversation", "id": id, "items": items.resultMap])
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

           var items: Item {
            get {
              return Item(unsafeResultMap: resultMap["items"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "items")
            }
          }

           struct Item: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["ConversationItemsPage"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("hasMore", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("nextCursor", type: .scalar(String.self)),
                GraphQLField("data", type: .nonNull(.list(.object(Datum.selections)))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(hasMore: Bool, nextCursor: String? = nil, data: [Datum?]) {
              self.init(unsafeResultMap: ["__typename": "ConversationItemsPage", "hasMore": hasMore, "nextCursor": nextCursor, "data": data.map { (value: Datum?) -> ResultMap? in value.flatMap { (value: Datum) -> ResultMap in value.resultMap } }])
            }

             var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

             var hasMore: Bool {
              get {
                return resultMap["hasMore"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "hasMore")
              }
            }

             var nextCursor: String? {
              get {
                return resultMap["nextCursor"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "nextCursor")
              }
            }

             var data: [Datum?] {
              get {
                return (resultMap["data"] as! [ResultMap?]).map { (value: ResultMap?) -> Datum? in value.flatMap { (value: ResultMap) -> Datum in Datum(unsafeResultMap: value) } }
              }
              set {
                resultMap.updateValue(newValue.map { (value: Datum?) -> ResultMap? in value.flatMap { (value: Datum) -> ResultMap in value.resultMap } }, forKey: "data")
              }
            }

             struct Datum: GraphQLSelectionSet {
               static let possibleTypes: [String] = ["Message", "ConversationActivity"]

               static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(ConversationItemFragment.self),
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

                 var conversationItemFragment: ConversationItemFragment {
                  get {
                    return ConversationItemFragment(unsafeResultMap: resultMap)
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
    }
  }
}
