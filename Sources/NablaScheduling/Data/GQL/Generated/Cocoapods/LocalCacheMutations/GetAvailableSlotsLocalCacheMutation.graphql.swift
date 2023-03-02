// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class GetAvailableSlotsLocalCacheMutation: LocalCacheMutation {
    static let operationType: GraphQLOperationType = .query

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

    var __variables: GraphQLOperation.Variables? { [
      "isPhysical": isPhysical,
      "categoryId": categoryId,
      "page": page
    ] }

    struct Data: GQL.MutableSelectionSet {
      var __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("appointmentCategory", AppointmentCategory.self, arguments: ["id": .variable("categoryId")]),
      ] }

      var appointmentCategory: AppointmentCategory {
        get { __data["appointmentCategory"] }
        set { __data["appointmentCategory"] = newValue }
      }

      /// AppointmentCategory
      ///
      /// Parent Type: `AppointmentCategoryOutput`
      struct AppointmentCategory: GQL.MutableSelectionSet {
        var __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentCategoryOutput }
        static var __selections: [Apollo.Selection] { [
          .field("category", Category.self),
        ] }

        var category: Category {
          get { __data["category"] }
          set { __data["category"] = newValue }
        }

        /// AppointmentCategory.Category
        ///
        /// Parent Type: `AppointmentCategory`
        struct Category: GQL.MutableSelectionSet {
          var __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentCategory }
          static var __selections: [Apollo.Selection] { [
            .field("id", GQL.UUID.self),
            .field("availableSlotsV2", AvailableSlotsV2.self, arguments: [
              "isPhysical": .variable("isPhysical"),
              "page": .variable("page")
            ]),
          ] }

          var id: GQL.UUID {
            get { __data["id"] }
            set { __data["id"] = newValue }
          }
          var availableSlotsV2: AvailableSlotsV2 {
            get { __data["availableSlotsV2"] }
            set { __data["availableSlotsV2"] = newValue }
          }

          /// AppointmentCategory.Category.AvailableSlotsV2
          ///
          /// Parent Type: `AvailableSlotsPage`
          struct AvailableSlotsV2: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.AvailableSlotsPage }
            static var __selections: [Apollo.Selection] { [
              .field("hasMore", Bool.self),
              .field("nextCursor", String?.self),
              .field("slots", [Slot].self),
            ] }

            var hasMore: Bool {
              get { __data["hasMore"] }
              set { __data["hasMore"] = newValue }
            }
            var nextCursor: String? {
              get { __data["nextCursor"] }
              set { __data["nextCursor"] = newValue }
            }
            var slots: [Slot] {
              get { __data["slots"] }
              set { __data["slots"] = newValue }
            }

            /// AppointmentCategory.Category.AvailableSlotsV2.Slot
            ///
            /// Parent Type: `AvailabilitySlot`
            struct Slot: GQL.MutableSelectionSet {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.AvailabilitySlot }
              static var __selections: [Apollo.Selection] { [
                .fragment(AvailabilitySlotFragment.self),
              ] }

              var startAt: GQL.DateTime {
                get { __data["startAt"] }
                set { __data["startAt"] = newValue }
              }
              var endAt: GQL.DateTime {
                get { __data["endAt"] }
                set { __data["endAt"] = newValue }
              }
              var provider: AvailabilitySlotFragment.Provider {
                get { __data["provider"] }
                set { __data["provider"] = newValue }
              }

              struct Fragments: FragmentContainer {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                var availabilitySlotFragment: AvailabilitySlotFragment {
                  get { _toFragment() }
                  _modify { var f = availabilitySlotFragment; yield &f; __data = f.__data }
                  @available(*, unavailable, message: "mutate properties of the fragment instead.")
                  set { preconditionFailure() }
                }
              }
            }
          }
        }
      }
    }
  }

}