// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct SystemMessageFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment SystemMessageFragment on System {
        __typename
        avatar {
          __typename
          url {
            __typename
            ...EphemeralUrlFragment
          }
        }
        name
      }
      """

     static let possibleTypes: [String] = ["System"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatar", type: .object(Avatar.selections)),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(avatar: Avatar? = nil, name: String) {
      self.init(unsafeResultMap: ["__typename": "System", "avatar": avatar.flatMap { (value: Avatar) -> ResultMap in value.resultMap }, "name": name])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var avatar: Avatar? {
      get {
        return (resultMap["avatar"] as? ResultMap).flatMap { Avatar(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "avatar")
      }
    }

     var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

     struct Avatar: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["ImageFileUpload"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .nonNull(.object(Url.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(url: Url) {
        self.init(unsafeResultMap: ["__typename": "ImageFileUpload", "url": url.resultMap])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var url: Url {
        get {
          return Url(unsafeResultMap: resultMap["url"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "url")
        }
      }

       struct Url: GraphQLSelectionSet {
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
    }
  }
}
