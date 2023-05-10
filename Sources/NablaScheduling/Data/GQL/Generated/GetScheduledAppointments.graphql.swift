// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class GetScheduledAppointmentsQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      query GetScheduledAppointments($page: OpaqueCursorPage!) {
        upcomingAppointments(page: $page) {
          __typename
          hasMore
          nextCursor
          data {
            __typename
            ...AppointmentFragment
          }
        }
      }
      """

     let operationName: String = "GetScheduledAppointments"

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

     var page: OpaqueCursorPage

     init(page: OpaqueCursorPage) {
      self.page = page
    }

     var variables: GraphQLMap? {
      return ["page": page]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Query"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("upcomingAppointments", arguments: ["page": GraphQLVariable("page")], type: .nonNull(.object(UpcomingAppointment.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(upcomingAppointments: UpcomingAppointment) {
        self.init(unsafeResultMap: ["__typename": "Query", "upcomingAppointments": upcomingAppointments.resultMap])
      }

       var upcomingAppointments: UpcomingAppointment {
        get {
          return UpcomingAppointment(unsafeResultMap: resultMap["upcomingAppointments"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "upcomingAppointments")
        }
      }

       struct UpcomingAppointment: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["AppointmentsPage"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("hasMore", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("nextCursor", type: .scalar(String.self)),
            GraphQLField("data", type: .nonNull(.list(.nonNull(.object(Datum.selections))))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(hasMore: Bool, nextCursor: String? = nil, data: [Datum]) {
          self.init(unsafeResultMap: ["__typename": "AppointmentsPage", "hasMore": hasMore, "nextCursor": nextCursor, "data": data.map { (value: Datum) -> ResultMap in value.resultMap }])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var hasMore: Bool {
          get {
            return resultMap["hasMore"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasMore")
          }
        }

         var nextCursor: String? {
          get {
            return resultMap["nextCursor"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "nextCursor")
          }
        }

         var data: [Datum] {
          get {
            return (resultMap["data"] as! [ResultMap]).map { (value: ResultMap) -> Datum in Datum(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Datum) -> ResultMap in value.resultMap }, forKey: "data")
          }
        }

         struct Datum: GraphQLSelectionSet {
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
