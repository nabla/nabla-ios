// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class CancelAppointmentMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      mutation cancelAppointment($appointmentId: UUID!) {
        cancelAppointment(id: $appointmentId) {
          __typename
          appointmentUuid
        }
      }
      """

     let operationName: String = "cancelAppointment"

     var appointmentId: GQL.UUID

     init(appointmentId: GQL.UUID) {
      self.appointmentId = appointmentId
    }

     var variables: GraphQLMap? {
      return ["appointmentId": appointmentId]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Mutation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("cancelAppointment", arguments: ["id": GraphQLVariable("appointmentId")], type: .nonNull(.object(CancelAppointment.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(cancelAppointment: CancelAppointment) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "cancelAppointment": cancelAppointment.resultMap])
      }

       var cancelAppointment: CancelAppointment {
        get {
          return CancelAppointment(unsafeResultMap: resultMap["cancelAppointment"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "cancelAppointment")
        }
      }

       struct CancelAppointment: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["CancelAppointmentOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("appointmentUuid", type: .nonNull(.scalar(GQL.UUID.self))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(appointmentUuid: GQL.UUID) {
          self.init(unsafeResultMap: ["__typename": "CancelAppointmentOutput", "appointmentUuid": appointmentUuid])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var appointmentUuid: GQL.UUID {
          get {
            return resultMap["appointmentUuid"]! as! GQL.UUID
          }
          set {
            resultMap.updateValue(newValue, forKey: "appointmentUuid")
          }
        }
      }
    }
  }
}
