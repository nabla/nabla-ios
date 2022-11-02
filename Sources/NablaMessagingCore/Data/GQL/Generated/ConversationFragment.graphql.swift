// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct ConversationFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment ConversationFragment on Conversation {
        __typename
        id
        title
        subtitle
        lastMessagePreview
        unreadMessageCount
        inboxPreviewTitle
        updatedAt
        pictureUrl {
          __typename
          ...EphemeralUrlFragment
        }
        providers {
          __typename
          ...ProviderInConversationFragment
        }
      }
      """

     static let possibleTypes: [String] = ["Conversation"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("subtitle", type: .scalar(String.self)),
        GraphQLField("lastMessagePreview", type: .scalar(String.self)),
        GraphQLField("unreadMessageCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("inboxPreviewTitle", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("pictureUrl", type: .object(PictureUrl.selections)),
        GraphQLField("providers", type: .nonNull(.list(.nonNull(.object(Provider.selections))))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(id: GQL.UUID, title: String? = nil, subtitle: String? = nil, lastMessagePreview: String? = nil, unreadMessageCount: Int, inboxPreviewTitle: String, updatedAt: GQL.DateTime, pictureUrl: PictureUrl? = nil, providers: [Provider]) {
      self.init(unsafeResultMap: ["__typename": "Conversation", "id": id, "title": title, "subtitle": subtitle, "lastMessagePreview": lastMessagePreview, "unreadMessageCount": unreadMessageCount, "inboxPreviewTitle": inboxPreviewTitle, "updatedAt": updatedAt, "pictureUrl": pictureUrl.flatMap { (value: PictureUrl) -> ResultMap in value.resultMap }, "providers": providers.map { (value: Provider) -> ResultMap in value.resultMap }])
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

     var title: String? {
      get {
        return resultMap["title"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "title")
      }
    }

     var subtitle: String? {
      get {
        return resultMap["subtitle"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "subtitle")
      }
    }

     var lastMessagePreview: String? {
      get {
        return resultMap["lastMessagePreview"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "lastMessagePreview")
      }
    }

     var unreadMessageCount: Int {
      get {
        return resultMap["unreadMessageCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "unreadMessageCount")
      }
    }

     var inboxPreviewTitle: String {
      get {
        return resultMap["inboxPreviewTitle"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "inboxPreviewTitle")
      }
    }

     var updatedAt: GQL.DateTime {
      get {
        return resultMap["updatedAt"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "updatedAt")
      }
    }

     var pictureUrl: PictureUrl? {
      get {
        return (resultMap["pictureUrl"] as? ResultMap).flatMap { PictureUrl(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "pictureUrl")
      }
    }

     var providers: [Provider] {
      get {
        return (resultMap["providers"] as! [ResultMap]).map { (value: ResultMap) -> Provider in Provider(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Provider) -> ResultMap in value.resultMap }, forKey: "providers")
      }
    }

     struct PictureUrl: GraphQLSelectionSet {
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

     struct Provider: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["ProviderInConversation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ProviderInConversationFragment.self),
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

         var providerInConversationFragment: ProviderInConversationFragment {
          get {
            return ProviderInConversationFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
