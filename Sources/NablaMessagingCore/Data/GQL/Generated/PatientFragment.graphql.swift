// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct PatientFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment PatientFragment on Patient {
        __typename
        id
        isMe
        displayName
      }
      """

     static let possibleTypes: [String] = ["Patient"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("isMe", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("displayName", type: .nonNull(.scalar(String.self))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(id: GQL.UUID, isMe: Bool, displayName: String) {
      self.init(unsafeResultMap: ["__typename": "Patient", "id": id, "isMe": isMe, "displayName": displayName])
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

     var isMe: Bool {
      get {
        return resultMap["isMe"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "isMe")
      }
    }

     var displayName: String {
      get {
        return resultMap["displayName"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "displayName")
      }
    }
  }
}
