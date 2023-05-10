// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class SchedulePendingAppointmentMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      mutation schedulePendingAppointment($appointmentId: UUID!) {
        schedulePendingAppointment(appointmentId: $appointmentId) {
          __typename
          appointment {
            __typename
            ...AppointmentFragment
          }
        }
      }
      """

     let operationName: String = "schedulePendingAppointment"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + AppointmentFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + PendingAppointmentFragment.fragmentDefinition)
      document.append("\n" + PriceFragment.fragmentDefinition)
      document.append("\n" + ScheduledAppointmentFragment.fragmentDefinition)
      document.append("\n" + FinalizedAppointmentFragment.fragmentDefinition)
      document.append("\n" + LocationFragment.fragmentDefinition)
      document.append("\n" + AddressFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomOpenStatusFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomClosedStatusFragment.fragmentDefinition)
      return document
    }

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
          GraphQLField("schedulePendingAppointment", arguments: ["appointmentId": GraphQLVariable("appointmentId")], type: .nonNull(.object(SchedulePendingAppointment.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(schedulePendingAppointment: SchedulePendingAppointment) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "schedulePendingAppointment": schedulePendingAppointment.resultMap])
      }

       var schedulePendingAppointment: SchedulePendingAppointment {
        get {
          return SchedulePendingAppointment(unsafeResultMap: resultMap["schedulePendingAppointment"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "schedulePendingAppointment")
        }
      }

       struct SchedulePendingAppointment: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["ScheduleAppointmentOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("appointment", type: .nonNull(.object(Appointment.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(appointment: Appointment) {
          self.init(unsafeResultMap: ["__typename": "ScheduleAppointmentOutput", "appointment": appointment.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var appointment: Appointment {
          get {
            return Appointment(unsafeResultMap: resultMap["appointment"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "appointment")
          }
        }

         struct Appointment: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["Appointment"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(AppointmentFragment.self),
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

             var appointmentFragment: AppointmentFragment {
              get {
                return AppointmentFragment(unsafeResultMap: resultMap)
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
}
