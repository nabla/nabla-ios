// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct PriceFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment PriceFragment on Price {
        __typename
        amount
        currencyCode
      }
      """

     static let possibleTypes: [String] = ["Price"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("amount", type: .nonNull(.scalar(GQL.BigDecimal.self))),
        GraphQLField("currencyCode", type: .nonNull(.scalar(String.self))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(amount: GQL.BigDecimal, currencyCode: String) {
      self.init(unsafeResultMap: ["__typename": "Price", "amount": amount, "currencyCode": currencyCode])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var amount: GQL.BigDecimal {
      get {
        return resultMap["amount"]! as! GQL.BigDecimal
      }
      set {
        resultMap.updateValue(newValue, forKey: "amount")
      }
    }

     var currencyCode: String {
      get {
        return resultMap["currencyCode"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "currencyCode")
      }
    }
  }
}
