// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct AddressFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment AddressFragment on Address {
        __typename
        id
        address
        zipCode
        city
        state
        country
        extraDetails
      }
      """

     static let possibleTypes: [String] = ["Address"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("zipCode", type: .nonNull(.scalar(String.self))),
        GraphQLField("city", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("country", type: .scalar(String.self)),
        GraphQLField("extraDetails", type: .scalar(String.self)),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(id: GQL.UUID, address: String, zipCode: String, city: String, state: String? = nil, country: String? = nil, extraDetails: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Address", "id": id, "address": address, "zipCode": zipCode, "city": city, "state": state, "country": country, "extraDetails": extraDetails])
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

     var address: String {
      get {
        return resultMap["address"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "address")
      }
    }

     var zipCode: String {
      get {
        return resultMap["zipCode"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "zipCode")
      }
    }

     var city: String {
      get {
        return resultMap["city"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "city")
      }
    }

     var state: String? {
      get {
        return resultMap["state"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "state")
      }
    }

     var country: String? {
      get {
        return resultMap["country"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "country")
      }
    }

     var extraDetails: String? {
      get {
        return resultMap["extraDetails"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "extraDetails")
      }
    }
  }
}
