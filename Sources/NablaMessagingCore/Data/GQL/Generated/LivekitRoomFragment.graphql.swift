// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct LivekitRoomOpenStatusFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment LivekitRoomOpenStatusFragment on LivekitRoomOpenStatus {
        __typename
        url
        token
      }
      """

     static let possibleTypes: [String] = ["LivekitRoomOpenStatus"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("url", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .nonNull(.scalar(String.self))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(url: String, token: String) {
      self.init(unsafeResultMap: ["__typename": "LivekitRoomOpenStatus", "url": url, "token": token])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var url: String {
      get {
        return resultMap["url"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "url")
      }
    }

     var token: String {
      get {
        return resultMap["token"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "token")
      }
    }
  }

  struct LivekitRoomClosedStatusFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment LivekitRoomClosedStatusFragment on LivekitRoomClosedStatus {
        __typename
        _
      }
      """

     static let possibleTypes: [String] = ["LivekitRoomClosedStatus"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_", type: .scalar(EmptyObject.self)),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(`_`: EmptyObject? = nil) {
      self.init(unsafeResultMap: ["__typename": "LivekitRoomClosedStatus", "_": `_`])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var `_`: EmptyObject? {
      get {
        return resultMap["_"] as? EmptyObject
      }
      set {
        resultMap.updateValue(newValue, forKey: "_")
      }
    }
  }

  struct LivekitRoomFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment LivekitRoomFragment on LivekitRoom {
        __typename
        uuid
        status {
          __typename
          ... on LivekitRoomOpenStatus {
            __typename
            ...LivekitRoomOpenStatusFragment
          }
          ... on LivekitRoomClosedStatus {
            __typename
            ...LivekitRoomClosedStatusFragment
          }
        }
      }
      """

     static let possibleTypes: [String] = ["LivekitRoom"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("uuid", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("status", type: .nonNull(.object(Status.selections))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(uuid: GQL.UUID, status: Status) {
      self.init(unsafeResultMap: ["__typename": "LivekitRoom", "uuid": uuid, "status": status.resultMap])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var uuid: GQL.UUID {
      get {
        return resultMap["uuid"]! as! GQL.UUID
      }
      set {
        resultMap.updateValue(newValue, forKey: "uuid")
      }
    }

     var status: Status {
      get {
        return Status(unsafeResultMap: resultMap["status"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "status")
      }
    }

     struct Status: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["LivekitRoomOpenStatus", "LivekitRoomClosedStatus"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLTypeCase(
            variants: ["LivekitRoomOpenStatus": AsLivekitRoomOpenStatus.selections, "LivekitRoomClosedStatus": AsLivekitRoomClosedStatus.selections],
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

       static func makeLivekitRoomOpenStatus(url: String, token: String) -> Status {
        return Status(unsafeResultMap: ["__typename": "LivekitRoomOpenStatus", "url": url, "token": token])
      }

       static func makeLivekitRoomClosedStatus(`_`: EmptyObject? = nil) -> Status {
        return Status(unsafeResultMap: ["__typename": "LivekitRoomClosedStatus", "_": `_`])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var asLivekitRoomOpenStatus: AsLivekitRoomOpenStatus? {
        get {
          if !AsLivekitRoomOpenStatus.possibleTypes.contains(__typename) { return nil }
          return AsLivekitRoomOpenStatus(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

       struct AsLivekitRoomOpenStatus: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["LivekitRoomOpenStatus"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(LivekitRoomOpenStatusFragment.self),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(url: String, token: String) {
          self.init(unsafeResultMap: ["__typename": "LivekitRoomOpenStatus", "url": url, "token": token])
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

           var livekitRoomOpenStatusFragment: LivekitRoomOpenStatusFragment {
            get {
              return LivekitRoomOpenStatusFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

       var asLivekitRoomClosedStatus: AsLivekitRoomClosedStatus? {
        get {
          if !AsLivekitRoomClosedStatus.possibleTypes.contains(__typename) { return nil }
          return AsLivekitRoomClosedStatus(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

       struct AsLivekitRoomClosedStatus: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["LivekitRoomClosedStatus"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(LivekitRoomClosedStatusFragment.self),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(`_`: EmptyObject? = nil) {
          self.init(unsafeResultMap: ["__typename": "LivekitRoomClosedStatus", "_": `_`])
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

           var livekitRoomClosedStatusFragment: LivekitRoomClosedStatusFragment {
            get {
              return LivekitRoomClosedStatusFragment(unsafeResultMap: resultMap)
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
