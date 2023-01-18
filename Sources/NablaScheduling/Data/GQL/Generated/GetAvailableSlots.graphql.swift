// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class GetAvailableSlotsQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      query GetAvailableSlots($isPhysical: Boolean!, $categoryId: UUID!, $page: OpaqueCursorPage!) {
        appointmentCategory(id: $categoryId) {
          __typename
          category {
            __typename
            id
            availableSlotsV2(isPhysical: $isPhysical, page: $page) {
              __typename
              hasMore
              nextCursor
              slots {
                __typename
                ...AvailabilitySlotFragment
              }
            }
          }
        }
      }
      """

     let operationName: String = "GetAvailableSlots"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + AvailabilitySlotFragment.fragmentDefinition)
      document.append("\n" + AddressFragment.fragmentDefinition)
      return document
    }

     var isPhysical: Bool
     var categoryId: GQL.UUID
     var page: OpaqueCursorPage

     init(isPhysical: Bool, categoryId: GQL.UUID, page: OpaqueCursorPage) {
      self.isPhysical = isPhysical
      self.categoryId = categoryId
      self.page = page
    }

     var variables: GraphQLMap? {
      return ["isPhysical": isPhysical, "categoryId": categoryId, "page": page]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Query"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("appointmentCategory", arguments: ["id": GraphQLVariable("categoryId")], type: .nonNull(.object(AppointmentCategory.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(appointmentCategory: AppointmentCategory) {
        self.init(unsafeResultMap: ["__typename": "Query", "appointmentCategory": appointmentCategory.resultMap])
      }

       var appointmentCategory: AppointmentCategory {
        get {
          return AppointmentCategory(unsafeResultMap: resultMap["appointmentCategory"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "appointmentCategory")
        }
      }

       struct AppointmentCategory: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["AppointmentCategoryOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("category", type: .nonNull(.object(Category.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(category: Category) {
          self.init(unsafeResultMap: ["__typename": "AppointmentCategoryOutput", "category": category.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var category: Category {
          get {
            return Category(unsafeResultMap: resultMap["category"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "category")
          }
        }

         struct Category: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["AppointmentCategory"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
              GraphQLField("availableSlotsV2", arguments: ["isPhysical": GraphQLVariable("isPhysical"), "page": GraphQLVariable("page")], type: .nonNull(.object(AvailableSlotsV2.selections))),
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           init(id: GQL.UUID, availableSlotsV2: AvailableSlotsV2) {
            self.init(unsafeResultMap: ["__typename": "AppointmentCategory", "id": id, "availableSlotsV2": availableSlotsV2.resultMap])
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

           var availableSlotsV2: AvailableSlotsV2 {
            get {
              return AvailableSlotsV2(unsafeResultMap: resultMap["availableSlotsV2"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "availableSlotsV2")
            }
          }

           struct AvailableSlotsV2: GraphQLSelectionSet {
             static let possibleTypes: [String] = ["AvailableSlotsPage"]

             static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("hasMore", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("nextCursor", type: .scalar(String.self)),
                GraphQLField("slots", type: .nonNull(.list(.nonNull(.object(Slot.selections))))),
              ]
            }

             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             init(hasMore: Bool, nextCursor: String? = nil, slots: [Slot]) {
              self.init(unsafeResultMap: ["__typename": "AvailableSlotsPage", "hasMore": hasMore, "nextCursor": nextCursor, "slots": slots.map { (value: Slot) -> ResultMap in value.resultMap }])
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

             var slots: [Slot] {
              get {
                return (resultMap["slots"] as! [ResultMap]).map { (value: ResultMap) -> Slot in Slot(unsafeResultMap: value) }
              }
              set {
                resultMap.updateValue(newValue.map { (value: Slot) -> ResultMap in value.resultMap }, forKey: "slots")
              }
            }

             struct Slot: GraphQLSelectionSet {
               static let possibleTypes: [String] = ["AvailabilitySlot"]

               static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(AvailabilitySlotFragment.self),
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

                 var availabilitySlotFragment: AvailabilitySlotFragment {
                  get {
                    return AvailabilitySlotFragment(unsafeResultMap: resultMap)
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
  }
}
