// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class GetAvailableSlotsQuery: GraphQLQuery {
    static let operationName: String = "GetAvailableSlots"
    static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
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
        """#,
        fragments: [AvailabilitySlotFragment.self]
      ))

    var isPhysical: Bool
    var categoryId: UUID
    var page: OpaqueCursorPage

    init(
      isPhysical: Bool,
      categoryId: UUID,
      page: OpaqueCursorPage
    ) {
      self.isPhysical = isPhysical
      self.categoryId = categoryId
      self.page = page
    }

    var __variables: Variables? { [
      "isPhysical": isPhysical,
      "categoryId": categoryId,
      "page": page
    ] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("appointmentCategory", AppointmentCategory.self, arguments: ["id": .variable("categoryId")]),
      ] }

      var appointmentCategory: AppointmentCategory { __data["appointmentCategory"] }

      /// AppointmentCategory
      ///
      /// Parent Type: `AppointmentCategoryOutput`
      struct AppointmentCategory: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.AppointmentCategoryOutput }
        static var __selections: [ApolloAPI.Selection] { [
          .field("category", Category.self),
        ] }

        var category: Category { __data["category"] }

        /// AppointmentCategory.Category
        ///
        /// Parent Type: `AppointmentCategory`
        struct Category: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: ApolloAPI.ParentType { GQL.Objects.AppointmentCategory }
          static var __selections: [ApolloAPI.Selection] { [
            .field("id", GQL.UUID.self),
            .field("availableSlotsV2", AvailableSlotsV2.self, arguments: [
              "isPhysical": .variable("isPhysical"),
              "page": .variable("page")
            ]),
          ] }

          var id: GQL.UUID { __data["id"] }
          var availableSlotsV2: AvailableSlotsV2 { __data["availableSlotsV2"] }

          /// AppointmentCategory.Category.AvailableSlotsV2
          ///
          /// Parent Type: `AvailableSlotsPage`
          struct AvailableSlotsV2: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.AvailableSlotsPage }
            static var __selections: [ApolloAPI.Selection] { [
              .field("hasMore", Bool.self),
              .field("nextCursor", String?.self),
              .field("slots", [Slot].self),
            ] }

            var hasMore: Bool { __data["hasMore"] }
            var nextCursor: String? { __data["nextCursor"] }
            var slots: [Slot] { __data["slots"] }

            /// AppointmentCategory.Category.AvailableSlotsV2.Slot
            ///
            /// Parent Type: `AvailabilitySlot`
            struct Slot: GQL.SelectionSet {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: ApolloAPI.ParentType { GQL.Objects.AvailabilitySlot }
              static var __selections: [ApolloAPI.Selection] { [
                .fragment(AvailabilitySlotFragment.self),
              ] }

              var startAt: GQL.DateTime { __data["startAt"] }
              var endAt: GQL.DateTime { __data["endAt"] }
              var provider: AvailabilitySlotFragment.Provider { __data["provider"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var availabilitySlotFragment: AvailabilitySlotFragment { _toFragment() }
              }
            }
          }
        }
      }
    }
  }

}