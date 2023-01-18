// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class GetAvailableLocationsQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      query GetAvailableLocations {
        appointmentAvailableLocations {
          __typename
          hasPhysicalAvailabilities
          hasRemoteAvailabilities
        }
      }
      """

     let operationName: String = "GetAvailableLocations"

     init() {
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Query"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("appointmentAvailableLocations", type: .nonNull(.object(AppointmentAvailableLocation.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(appointmentAvailableLocations: AppointmentAvailableLocation) {
        self.init(unsafeResultMap: ["__typename": "Query", "appointmentAvailableLocations": appointmentAvailableLocations.resultMap])
      }

       var appointmentAvailableLocations: AppointmentAvailableLocation {
        get {
          return AppointmentAvailableLocation(unsafeResultMap: resultMap["appointmentAvailableLocations"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "appointmentAvailableLocations")
        }
      }

       struct AppointmentAvailableLocation: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["AppointmentAvailableLocationsOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("hasPhysicalAvailabilities", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("hasRemoteAvailabilities", type: .nonNull(.scalar(Bool.self))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(hasPhysicalAvailabilities: Bool, hasRemoteAvailabilities: Bool) {
          self.init(unsafeResultMap: ["__typename": "AppointmentAvailableLocationsOutput", "hasPhysicalAvailabilities": hasPhysicalAvailabilities, "hasRemoteAvailabilities": hasRemoteAvailabilities])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var hasPhysicalAvailabilities: Bool {
          get {
            return resultMap["hasPhysicalAvailabilities"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasPhysicalAvailabilities")
          }
        }

         var hasRemoteAvailabilities: Bool {
          get {
            return resultMap["hasRemoteAvailabilities"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasRemoteAvailabilities")
          }
        }
      }
    }
  }
}
