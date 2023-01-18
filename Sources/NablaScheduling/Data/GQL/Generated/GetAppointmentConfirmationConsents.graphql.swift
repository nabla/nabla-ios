// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class GetAppointmentConfirmationConsentsQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      query GetAppointmentConfirmationConsents {
        appointmentConfirmationConsents {
          __typename
          firstConsentHtml
          secondConsentHtml
          physicalFirstConsentHtml
          physicalSecondConsentHtml
        }
      }
      """

     let operationName: String = "GetAppointmentConfirmationConsents"

     init() {
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Query"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("appointmentConfirmationConsents", type: .nonNull(.object(AppointmentConfirmationConsent.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(appointmentConfirmationConsents: AppointmentConfirmationConsent) {
        self.init(unsafeResultMap: ["__typename": "Query", "appointmentConfirmationConsents": appointmentConfirmationConsents.resultMap])
      }

       var appointmentConfirmationConsents: AppointmentConfirmationConsent {
        get {
          return AppointmentConfirmationConsent(unsafeResultMap: resultMap["appointmentConfirmationConsents"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "appointmentConfirmationConsents")
        }
      }

       struct AppointmentConfirmationConsent: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["AppointmentConfirmationConsentsOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("firstConsentHtml", type: .nonNull(.scalar(String.self))),
            GraphQLField("secondConsentHtml", type: .nonNull(.scalar(String.self))),
            GraphQLField("physicalFirstConsentHtml", type: .nonNull(.scalar(String.self))),
            GraphQLField("physicalSecondConsentHtml", type: .nonNull(.scalar(String.self))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(firstConsentHtml: String, secondConsentHtml: String, physicalFirstConsentHtml: String, physicalSecondConsentHtml: String) {
          self.init(unsafeResultMap: ["__typename": "AppointmentConfirmationConsentsOutput", "firstConsentHtml": firstConsentHtml, "secondConsentHtml": secondConsentHtml, "physicalFirstConsentHtml": physicalFirstConsentHtml, "physicalSecondConsentHtml": physicalSecondConsentHtml])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var firstConsentHtml: String {
          get {
            return resultMap["firstConsentHtml"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstConsentHtml")
          }
        }

         var secondConsentHtml: String {
          get {
            return resultMap["secondConsentHtml"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "secondConsentHtml")
          }
        }

         var physicalFirstConsentHtml: String {
          get {
            return resultMap["physicalFirstConsentHtml"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "physicalFirstConsentHtml")
          }
        }

         var physicalSecondConsentHtml: String {
          get {
            return resultMap["physicalSecondConsentHtml"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "physicalSecondConsentHtml")
          }
        }
      }
    }
  }
}
