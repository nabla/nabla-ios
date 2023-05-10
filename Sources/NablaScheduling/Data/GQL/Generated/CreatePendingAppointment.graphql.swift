// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class CreatePendingAppointmentMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      mutation createPendingAppointment($isPhysical: Boolean!, $categoryId: UUID!, $providerId: UUID!, $startAt: DateTime!) {
        createPendingAppointment(
          categoryId: $categoryId
          providerId: $providerId
          isPhysical: $isPhysical
          startAt: $startAt
        ) {
          __typename
          appointment {
            __typename
            ...AppointmentFragment
          }
        }
      }
      """

     let operationName: String = "createPendingAppointment"

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

     var isPhysical: Bool
     var categoryId: GQL.UUID
     var providerId: GQL.UUID
     var startAt: GQL.DateTime

     init(isPhysical: Bool, categoryId: GQL.UUID, providerId: GQL.UUID, startAt: GQL.DateTime) {
      self.isPhysical = isPhysical
      self.categoryId = categoryId
      self.providerId = providerId
      self.startAt = startAt
    }

     var variables: GraphQLMap? {
      return ["isPhysical": isPhysical, "categoryId": categoryId, "providerId": providerId, "startAt": startAt]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Mutation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("createPendingAppointment", arguments: ["categoryId": GraphQLVariable("categoryId"), "providerId": GraphQLVariable("providerId"), "isPhysical": GraphQLVariable("isPhysical"), "startAt": GraphQLVariable("startAt")], type: .nonNull(.object(CreatePendingAppointment.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(createPendingAppointment: CreatePendingAppointment) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "createPendingAppointment": createPendingAppointment.resultMap])
      }

       var createPendingAppointment: CreatePendingAppointment {
        get {
          return CreatePendingAppointment(unsafeResultMap: resultMap["createPendingAppointment"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "createPendingAppointment")
        }
      }

       struct CreatePendingAppointment: GraphQLSelectionSet {
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
