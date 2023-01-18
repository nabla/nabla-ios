// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class AppointmentsEventsSubscription: GraphQLSubscription {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      subscription AppointmentsEvents {
        appointments {
          __typename
          event {
            __typename
            ... on SubscriptionReadinessEvent {
              __typename
              isReady
            }
            ... on AppointmentCreatedEvent {
              __typename
              appointment {
                __typename
                ...AppointmentFragment
              }
            }
            ... on AppointmentUpdatedEvent {
              __typename
              appointment {
                __typename
                ...AppointmentFragment
              }
            }
            ... on AppointmentCancelledEvent {
              __typename
              appointmentId
            }
          }
        }
      }
      """

     let operationName: String = "AppointmentsEvents"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + AppointmentFragment.fragmentDefinition)
      document.append("\n" + ProviderFragment.fragmentDefinition)
      document.append("\n" + UpcomingAppointmentFragment.fragmentDefinition)
      document.append("\n" + FinalizedAppointmentFragment.fragmentDefinition)
      document.append("\n" + LocationFragment.fragmentDefinition)
      document.append("\n" + AddressFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomOpenStatusFragment.fragmentDefinition)
      document.append("\n" + LivekitRoomClosedStatusFragment.fragmentDefinition)
      return document
    }

     init() {
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Subscription"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("appointments", type: .object(Appointment.selections)),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(appointments: Appointment? = nil) {
        self.init(unsafeResultMap: ["__typename": "Subscription", "appointments": appointments.flatMap { (value: Appointment) -> ResultMap in value.resultMap }])
      }

       var appointments: Appointment? {
        get {
          return (resultMap["appointments"] as? ResultMap).flatMap { Appointment(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "appointments")
        }
      }

       struct Appointment: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["AppointmentsEventOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("event", type: .nonNull(.object(Event.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(event: Event) {
          self.init(unsafeResultMap: ["__typename": "AppointmentsEventOutput", "event": event.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var event: Event {
          get {
            return Event(unsafeResultMap: resultMap["event"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "event")
          }
        }

         struct Event: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["SubscriptionReadinessEvent", "AppointmentCreatedEvent", "AppointmentUpdatedEvent", "AppointmentCancelledEvent"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLTypeCase(
                variants: ["SubscriptionReadinessEvent": AsSubscriptionReadinessEvent.selections, "AppointmentCreatedEvent": AsAppointmentCreatedEvent.selections, "AppointmentUpdatedEvent": AsAppointmentUpdatedEvent.selections, "AppointmentCancelledEvent": AsAppointmentCancelledEvent.selections],
                default: [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                ]
              )
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           static func makeSubscriptionReadinessEvent(isReady: Bool) -> Event {
            return Event(unsafeResultMap: ["__typename": "SubscriptionReadinessEvent", "isReady": isReady])
          }

           static func makeAppointmentCreatedEvent(appointment: AsAppointmentCreatedEvent.Appointment) -> Event {
            return Event(unsafeResultMap: ["__typename": "AppointmentCreatedEvent", "appointment": appointment.resultMap])
          }

           static func makeAppointmentUpdatedEvent(appointment: AsAppointmentUpdatedEvent.Appointment) -> Event {
            return Event(unsafeResultMap: ["__typename": "AppointmentUpdatedEvent", "appointment": appointment.resultMap])
          }

           static func makeAppointmentCancelledEvent(appointmentId: GQL.UUID) -> Event {
            return Event(unsafeResultMap: ["__typename": "AppointmentCancelledEvent", "appointmentId": appointmentId])
          }

           var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

           var asSubscriptionReadinessEvent: AsSubscriptionReadinessEvent? {
            get {
              if !AsSubscriptionReadinessEvent.possibleTypes.contains(__typename) { return nil }
              return AsSubscriptionReadinessEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsSubscriptionReadinessEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["SubscriptionReadinessEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("isReady", type: .nonNull(.scalar(Bool.self))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(isReady: Bool) {
              self.init(unsafeResultMap: ["__typename": "SubscriptionReadinessEvent", "isReady": isReady])
            }

             var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

             var isReady: Bool {
              get {
                return resultMap["isReady"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isReady")
              }
            }
          }

           var asAppointmentCreatedEvent: AsAppointmentCreatedEvent? {
            get {
              if !AsAppointmentCreatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsAppointmentCreatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsAppointmentCreatedEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["AppointmentCreatedEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("appointment", type: .nonNull(.object(Appointment.selections))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(appointment: Appointment) {
              self.init(unsafeResultMap: ["__typename": "AppointmentCreatedEvent", "appointment": appointment.resultMap])
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

           var asAppointmentUpdatedEvent: AsAppointmentUpdatedEvent? {
            get {
              if !AsAppointmentUpdatedEvent.possibleTypes.contains(__typename) { return nil }
              return AsAppointmentUpdatedEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsAppointmentUpdatedEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["AppointmentUpdatedEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("appointment", type: .nonNull(.object(Appointment.selections))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(appointment: Appointment) {
              self.init(unsafeResultMap: ["__typename": "AppointmentUpdatedEvent", "appointment": appointment.resultMap])
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

           var asAppointmentCancelledEvent: AsAppointmentCancelledEvent? {
            get {
              if !AsAppointmentCancelledEvent.possibleTypes.contains(__typename) { return nil }
              return AsAppointmentCancelledEvent(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap = newValue.resultMap
            }
          }

           struct AsAppointmentCancelledEvent: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["AppointmentCancelledEvent"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("appointmentId", type: .nonNull(.scalar(GQL.UUID.self))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(appointmentId: GQL.UUID) {
              self.init(unsafeResultMap: ["__typename": "AppointmentCancelledEvent", "appointmentId": appointmentId])
            }

             var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

             var appointmentId: GQL.UUID {
              get {
                return resultMap["appointmentId"]! as! GQL.UUID
              }
              set {
                resultMap.updateValue(newValue, forKey: "appointmentId")
              }
            }
          }
        }
      }
    }
  }
}
