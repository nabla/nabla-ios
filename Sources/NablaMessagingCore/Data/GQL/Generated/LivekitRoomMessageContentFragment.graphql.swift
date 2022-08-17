// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct LivekitRoomMessageContentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment LivekitRoomMessageContentFragment on LivekitRoomMessageContent {
        __typename
        livekitRoom {
          __typename
          ...LivekitRoomFragment
        }
      }
      """

     static let possibleTypes: [String] = ["LivekitRoomMessageContent"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("livekitRoom", type: .nonNull(.object(LivekitRoom.selections))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(livekitRoom: LivekitRoom) {
      self.init(unsafeResultMap: ["__typename": "LivekitRoomMessageContent", "livekitRoom": livekitRoom.resultMap])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var livekitRoom: LivekitRoom {
      get {
        return LivekitRoom(unsafeResultMap: resultMap["livekitRoom"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "livekitRoom")
      }
    }

     struct LivekitRoom: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["LivekitRoom"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(LivekitRoomFragment.self),
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

         var livekitRoomFragment: LivekitRoomFragment {
          get {
            return LivekitRoomFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
