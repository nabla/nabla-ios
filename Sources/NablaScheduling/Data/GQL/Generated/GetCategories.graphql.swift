// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class GetCategoriesQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      query GetCategories {
        appointmentCategories {
          __typename
          categories {
            __typename
            ...CategoryFragment
          }
        }
      }
      """

     let operationName: String = "GetCategories"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + CategoryFragment.fragmentDefinition)
      return document
    }

     init() {
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Query"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("appointmentCategories", type: .nonNull(.object(AppointmentCategory.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(appointmentCategories: AppointmentCategory) {
        self.init(unsafeResultMap: ["__typename": "Query", "appointmentCategories": appointmentCategories.resultMap])
      }

       var appointmentCategories: AppointmentCategory {
        get {
          return AppointmentCategory(unsafeResultMap: resultMap["appointmentCategories"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "appointmentCategories")
        }
      }

       struct AppointmentCategory: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["AppointmentCategoriesOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("categories", type: .nonNull(.list(.nonNull(.object(Category.selections))))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(categories: [Category]) {
          self.init(unsafeResultMap: ["__typename": "AppointmentCategoriesOutput", "categories": categories.map { (value: Category) -> ResultMap in value.resultMap }])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var categories: [Category] {
          get {
            return (resultMap["categories"] as! [ResultMap]).map { (value: ResultMap) -> Category in Category(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Category) -> ResultMap in value.resultMap }, forKey: "categories")
          }
        }

         struct Category: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["AppointmentCategory"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(CategoryFragment.self),
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           init(id: GQL.UUID, name: String) {
            self.init(unsafeResultMap: ["__typename": "AppointmentCategory", "id": id, "name": name])
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

             var categoryFragment: CategoryFragment {
              get {
                return CategoryFragment(unsafeResultMap: resultMap)
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
