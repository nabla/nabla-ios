// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

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

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
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

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.AppointmentCategoryOutput }
        static var __selections: [ApolloAPI.Selection] { [
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

          static var __parentType: ApolloAPI.ParentType { GQL.Objects.AppointmentCategory }
          static var __selections: [ApolloAPI.Selection] { [
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

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.AvailableSlotsPage }
            static var __selections: [ApolloAPI.Selection] { [
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

              static var __parentType: ApolloAPI.ParentType { GQL.Objects.AvailabilitySlot }
              static var __selections: [ApolloAPI.Selection] { [
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
              var location: Location {
                get { __data["location"] }
                set { __data["location"] = newValue }
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

              /// AppointmentCategory.Category.AvailableSlotsV2.Slot.Location
              ///
              /// Parent Type: `AvailabilitySlotLocation`
              struct Location: GQL.MutableSelectionSet {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: ApolloAPI.ParentType { GQL.Unions.AvailabilitySlotLocation }

                var asPhysicalAvailabilitySlotLocation: AsPhysicalAvailabilitySlotLocation? {
                  get { _asInlineFragment() }
                  set { if let newData = newValue?.__data._data { __data._data = newData }}
                }
                var asRemoteAvailabilitySlotLocation: AsRemoteAvailabilitySlotLocation? {
                  get { _asInlineFragment() }
                  set { if let newData = newValue?.__data._data { __data._data = newData }}
                }

                /// AppointmentCategory.Category.AvailableSlotsV2.Slot.Location.AsPhysicalAvailabilitySlotLocation
                ///
                /// Parent Type: `PhysicalAvailabilitySlotLocation`
                struct AsPhysicalAvailabilitySlotLocation: GQL.MutableInlineFragment {
                  var __data: DataDict
                  init(data: DataDict) { __data = data }

                  static var __parentType: ApolloAPI.ParentType { GQL.Objects.PhysicalAvailabilitySlotLocation }

                  var address: Address {
                    get { __data["address"] }
                    set { __data["address"] = newValue }
                  }

                  /// AppointmentCategory.Category.AvailableSlotsV2.Slot.Location.AsPhysicalAvailabilitySlotLocation.Address
                  ///
                  /// Parent Type: `Address`
                  struct Address: GQL.MutableSelectionSet {
                    var __data: DataDict
                    init(data: DataDict) { __data = data }

                    static var __parentType: ApolloAPI.ParentType { GQL.Objects.Address }

                    var id: GQL.UUID {
                      get { __data["id"] }
                      set { __data["id"] = newValue }
                    }
                    var address: String {
                      get { __data["address"] }
                      set { __data["address"] = newValue }
                    }
                    var zipCode: String {
                      get { __data["zipCode"] }
                      set { __data["zipCode"] = newValue }
                    }
                    var city: String {
                      get { __data["city"] }
                      set { __data["city"] = newValue }
                    }
                    var state: String? {
                      get { __data["state"] }
                      set { __data["state"] = newValue }
                    }
                    var country: String? {
                      get { __data["country"] }
                      set { __data["country"] = newValue }
                    }
                    var extraDetails: String? {
                      get { __data["extraDetails"] }
                      set { __data["extraDetails"] = newValue }
                    }

                    struct Fragments: FragmentContainer {
                      var __data: DataDict
                      init(data: DataDict) { __data = data }

                      var addressFragment: AddressFragment {
                        get { _toFragment() }
                        _modify { var f = addressFragment; yield &f; __data = f.__data }
                        @available(*, unavailable, message: "mutate properties of the fragment instead.")
                        set { preconditionFailure() }
                      }
                    }
                  }
                }

                /// AppointmentCategory.Category.AvailableSlotsV2.Slot.Location.AsRemoteAvailabilitySlotLocation
                ///
                /// Parent Type: `RemoteAvailabilitySlotLocation`
                struct AsRemoteAvailabilitySlotLocation: GQL.MutableInlineFragment {
                  var __data: DataDict
                  init(data: DataDict) { __data = data }

                  static var __parentType: ApolloAPI.ParentType { GQL.Objects.RemoteAvailabilitySlotLocation }

                  var `_`: GraphQLEnum<GQL.EmptyObject> {
                    get { __data["_"] }
                    set { __data["_"] = newValue }
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