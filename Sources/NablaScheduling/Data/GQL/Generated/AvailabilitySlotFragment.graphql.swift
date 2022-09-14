// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct AvailabilitySlotFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment AvailabilitySlotFragment on AvailabilitySlot {
        __typename
        startAt
        endAt
        provider {
          __typename
          id
        }
      }
      """

     static let possibleTypes: [String] = ["AvailabilitySlot"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("startAt", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("endAt", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("provider", type: .nonNull(.object(Provider.selections))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(startAt: GQL.DateTime, endAt: GQL.DateTime, provider: Provider) {
      self.init(unsafeResultMap: ["__typename": "AvailabilitySlot", "startAt": startAt, "endAt": endAt, "provider": provider.resultMap])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var startAt: GQL.DateTime {
      get {
        return resultMap["startAt"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "startAt")
      }
    }

     var endAt: GQL.DateTime {
      get {
        return resultMap["endAt"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "endAt")
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
       static let possibleTypes: [String] = ["Provider"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(id: GQL.UUID) {
        self.init(unsafeResultMap: ["__typename": "Provider", "id": id])
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
    }
  }
}
