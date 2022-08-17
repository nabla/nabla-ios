// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct ConversationActivityFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment ConversationActivityFragment on ConversationActivity {
        __typename
        id
        activityTime
        content {
          __typename
          ... on ProviderJoinedConversation {
            __typename
            provider {
              __typename
              ...MaybeProviderFragment
            }
          }
        }
      }
      """

     static let possibleTypes: [String] = ["ConversationActivity"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("activityTime", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("content", type: .nonNull(.object(Content.selections))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(id: GQL.UUID, activityTime: GQL.DateTime, content: Content) {
      self.init(unsafeResultMap: ["__typename": "ConversationActivity", "id": id, "activityTime": activityTime, "content": content.resultMap])
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

     var activityTime: GQL.DateTime {
      get {
        return resultMap["activityTime"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "activityTime")
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

     struct Content: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["ProviderJoinedConversation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("provider", type: .nonNull(.object(Provider.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(provider: Provider) {
        self.init(unsafeResultMap: ["__typename": "ProviderJoinedConversation", "provider": provider.resultMap])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var provider: Provider {
        get {
          return Provider(unsafeResultMap: resultMap["provider"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "provider")
        }
      }

       struct Provider: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["Provider", "DeletedProvider"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(MaybeProviderFragment.self),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         static func makeDeletedProvider(`_`: EmptyObject) -> Provider {
          return Provider(unsafeResultMap: ["__typename": "DeletedProvider", "_": `_`])
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

           var maybeProviderFragment: MaybeProviderFragment {
            get {
              return MaybeProviderFragment(unsafeResultMap: resultMap)
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
