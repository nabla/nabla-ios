// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class GetCategoriesQuery: GraphQLQuery {
    static let operationName: String = "GetCategories"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetCategories {
          appointmentCategories {
            __typename
            categories {
              __typename
              ...CategoryFragment
            }
          }
        }
        """#,
        fragments: [CategoryFragment.self]
      ))

    init() {}

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("appointmentCategories", AppointmentCategories.self),
      ] }

      var appointmentCategories: AppointmentCategories { __data["appointmentCategories"] }

      /// AppointmentCategories
      ///
      /// Parent Type: `AppointmentCategoriesOutput`
      struct AppointmentCategories: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentCategoriesOutput }
        static var __selections: [Apollo.Selection] { [
          .field("categories", [Category].self),
        ] }

        var categories: [Category] { __data["categories"] }

        /// AppointmentCategories.Category
        ///
        /// Parent Type: `AppointmentCategory`
        struct Category: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentCategory }
          static var __selections: [Apollo.Selection] { [
            .fragment(CategoryFragment.self),
          ] }

          var id: GQL.UUID { __data["id"] }
          var name: String { __data["name"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            var categoryFragment: CategoryFragment { _toFragment() }
          }
        }
      }
    }
  }

}