// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class ScheduleAppointmentMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      mutation scheduleAppointment($categoryId: UUID!, $providerId: UUID!, $timeSlot: DateTime!, $timeZone: TimeZone!) {
        scheduleAppointment(
          categoryId: $categoryId
          providerId: $providerId
          slot: $timeSlot
          timeZone: $timeZone
        ) {
          __typename
          appointment {
            __typename
            ...AppointmentFragment
          }
        }
      }
      """

     let operationName: String = "scheduleAppointment"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + AppointmentFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + UpcomingAppointmentFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomOpenStatusFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomClosedStatusFragment.fragmentDefinition)
      document.append("\n" + FinalizedAppointmentFragment.fragmentDefinition)
      return document
    }

     var categoryId: GQL.UUID
     var providerId: GQL.UUID
     var timeSlot: GQL.DateTime
     var timeZone: GQL.TimeZone

     init(categoryId: GQL.UUID, providerId: GQL.UUID, timeSlot: GQL.DateTime, timeZone: GQL.TimeZone) {
      self.categoryId = categoryId
      self.providerId = providerId
      self.timeSlot = timeSlot
      self.timeZone = timeZone
    }

     var variables: GraphQLMap? {
      return ["categoryId": categoryId, "providerId": providerId, "timeSlot": timeSlot, "timeZone": timeZone]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Mutation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("scheduleAppointment", arguments: ["categoryId": GraphQLVariable("categoryId"), "providerId": GraphQLVariable("providerId"), "slot": GraphQLVariable("timeSlot"), "timeZone": GraphQLVariable("timeZone")], type: .nonNull(.object(ScheduleAppointment.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(scheduleAppointment: ScheduleAppointment) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "scheduleAppointment": scheduleAppointment.resultMap])
      }

       var scheduleAppointment: ScheduleAppointment {
        get {
          return ScheduleAppointment(unsafeResultMap: resultMap["scheduleAppointment"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "scheduleAppointment")
        }
      }

       struct ScheduleAppointment: GraphQLSelectionSet {
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
