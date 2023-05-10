// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct EphemeralUrlFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment EphemeralUrlFragment on EphemeralUrl {
        __typename
        expiresAt
        url
      }
      """

     static let possibleTypes: [String] = ["EphemeralUrl"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("expiresAt", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("url", type: .nonNull(.scalar(String.self))),
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

     var expiresAt: GQL.DateTime {
      get {
        return resultMap["expiresAt"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "expiresAt")
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
  }
}
