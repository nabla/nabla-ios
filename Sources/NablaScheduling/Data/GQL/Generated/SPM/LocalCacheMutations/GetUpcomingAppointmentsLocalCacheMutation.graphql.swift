// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class GetUpcomingAppointmentsLocalCacheMutation: LocalCacheMutation {
    static let operationType: GraphQLOperationType = .query

    var page: OpaqueCursorPage

    init(page: OpaqueCursorPage) {
      self.page = page
    }

    var __variables: GraphQLOperation.Variables? { ["page": page] }

    struct Data: GQL.MutableSelectionSet {
      var __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("upcomingAppointments", UpcomingAppointments.self, arguments: ["page": .variable("page")]),
      ] }

      var upcomingAppointments: UpcomingAppointments {
        get { __data["upcomingAppointments"] }
        set { __data["upcomingAppointments"] = newValue }
      }

      /// UpcomingAppointments
      ///
      /// Parent Type: `AppointmentsPage`
      struct UpcomingAppointments: GQL.MutableSelectionSet {
        var __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.AppointmentsPage }
        static var __selections: [ApolloAPI.Selection] { [
          .field("hasMore", Bool.self),
          .field("nextCursor", String?.self),
          .field("data", [Datum].self),
        ] }

        var hasMore: Bool {
          get { __data["hasMore"] }
          set { __data["hasMore"] = newValue }
        }
        var nextCursor: String? {
          get { __data["nextCursor"] }
          set { __data["nextCursor"] = newValue }
        }
        var data: [Datum] {
          get { __data["data"] }
          set { __data["data"] = newValue }
        }

        /// UpcomingAppointments.Datum
        ///
        /// Parent Type: `Appointment`
        struct Datum: GQL.MutableSelectionSet {
          var __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: ApolloAPI.ParentType { GQL.Objects.Appointment }
          static var __selections: [ApolloAPI.Selection] { [
            .fragment(AppointmentFragment.self),
          ] }

          var id: GQL.UUID {
            get { __data["id"] }
            set { __data["id"] = newValue }
          }
          var scheduledAt: GQL.DateTime {
            get { __data["scheduledAt"] }
            set { __data["scheduledAt"] = newValue }
          }
          var provider: Provider {
            get { __data["provider"] }
            set { __data["provider"] = newValue }
          }
          var state: State {
            get { __data["state"] }
            set { __data["state"] = newValue }
          }
          var location: AppointmentFragment.Location {
            get { __data["location"] }
            set { __data["location"] = newValue }
          }
          var price: Price? {
            get { __data["price"] }
            set { __data["price"] = newValue }
          }

          struct Fragments: FragmentContainer {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            var appointmentFragment: AppointmentFragment {
              get { _toFragment() }
              _modify { var f = appointmentFragment; yield &f; __data = f.__data }
              @available(*, unavailable, message: "mutate properties of the fragment instead.")
              set { preconditionFailure() }
            }
          }

          /// UpcomingAppointments.Datum.Provider
          ///
          /// Parent Type: `Provider`
          struct Provider: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.Provider }

            var id: GQL.UUID {
              get { __data["id"] }
              set { __data["id"] = newValue }
            }
            var prefix: String? {
              get { __data["prefix"] }
              set { __data["prefix"] = newValue }
            }
            var firstName: String {
              get { __data["firstName"] }
              set { __data["firstName"] = newValue }
            }
            var lastName: String {
              get { __data["lastName"] }
              set { __data["lastName"] = newValue }
            }
            var title: String? {
              get { __data["title"] }
              set { __data["title"] = newValue }
            }
            var avatarUrl: ProviderFragment.AvatarUrl? {
              get { __data["avatarUrl"] }
              set { __data["avatarUrl"] = newValue }
            }

            struct Fragments: FragmentContainer {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              var providerFragment: ProviderFragment {
                get { _toFragment() }
                _modify { var f = providerFragment; yield &f; __data = f.__data }
                @available(*, unavailable, message: "mutate properties of the fragment instead.")
                set { preconditionFailure() }
              }
            }
          }

          /// UpcomingAppointments.Datum.State
          ///
          /// Parent Type: `AppointmentState`
          struct State: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Unions.AppointmentState }

            var asPendingAppointment: AsPendingAppointment? {
              get { _asInlineFragment() }
              set { if let newData = newValue?.__data._data { __data._data = newData }}
            }
            var asUpcomingAppointment: AsUpcomingAppointment? {
              get { _asInlineFragment() }
              set { if let newData = newValue?.__data._data { __data._data = newData }}
            }
            var asFinalizedAppointment: AsFinalizedAppointment? {
              get { _asInlineFragment() }
              set { if let newData = newValue?.__data._data { __data._data = newData }}
            }

            /// UpcomingAppointments.Datum.State.AsPendingAppointment
            ///
            /// Parent Type: `PendingAppointment`
            struct AsPendingAppointment: GQL.MutableInlineFragment {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: ApolloAPI.ParentType { GQL.Objects.PendingAppointment }

              var schedulingPaymentRequirement: PendingAppointmentFragment.SchedulingPaymentRequirement? {
                get { __data["schedulingPaymentRequirement"] }
                set { __data["schedulingPaymentRequirement"] = newValue }
              }

              struct Fragments: FragmentContainer {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                var pendingAppointmentFragment: PendingAppointmentFragment {
                  get { _toFragment() }
                  _modify { var f = pendingAppointmentFragment; yield &f; __data = f.__data }
                  @available(*, unavailable, message: "mutate properties of the fragment instead.")
                  set { preconditionFailure() }
                }
              }
            }

            /// UpcomingAppointments.Datum.State.AsUpcomingAppointment
            ///
            /// Parent Type: `UpcomingAppointment`
            struct AsUpcomingAppointment: GQL.MutableInlineFragment {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: ApolloAPI.ParentType { GQL.Objects.UpcomingAppointment }

              struct Fragments: FragmentContainer {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                var upcomingAppointmentFragment: UpcomingAppointmentFragment {
                  get { _toFragment() }
                  _modify { var f = upcomingAppointmentFragment; yield &f; __data = f.__data }
                  @available(*, unavailable, message: "mutate properties of the fragment instead.")
                  set { preconditionFailure() }
                }
              }
            }

            /// UpcomingAppointments.Datum.State.AsFinalizedAppointment
            ///
            /// Parent Type: `FinalizedAppointment`
            struct AsFinalizedAppointment: GQL.MutableInlineFragment {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: ApolloAPI.ParentType { GQL.Objects.FinalizedAppointment }

              var `_`: GraphQLEnum<GQL.EmptyObject> {
                get { __data["_"] }
                set { __data["_"] = newValue }
              }

              struct Fragments: FragmentContainer {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                var finalizedAppointmentFragment: FinalizedAppointmentFragment {
                  get { _toFragment() }
                  _modify { var f = finalizedAppointmentFragment; yield &f; __data = f.__data }
                  @available(*, unavailable, message: "mutate properties of the fragment instead.")
                  set { preconditionFailure() }
                }
              }
            }
          }

          /// UpcomingAppointments.Datum.Price
          ///
          /// Parent Type: `Price`
          struct Price: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.Price }

            var amount: GQL.BigDecimal {
              get { __data["amount"] }
              set { __data["amount"] = newValue }
            }
            var currencyCode: String {
              get { __data["currencyCode"] }
              set { __data["currencyCode"] = newValue }
            }

            struct Fragments: FragmentContainer {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              var priceFragment: PriceFragment {
                get { _toFragment() }
                _modify { var f = priceFragment; yield &f; __data = f.__data }
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