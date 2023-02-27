// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class GetUpcomingAppointmentsQuery: GraphQLQuery {
    static let operationName: String = "GetUpcomingAppointments"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetUpcomingAppointments($page: OpaqueCursorPage!) {
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
        """#,
        fragments: [AppointmentFragment.self, ProviderFragment.self, PendingAppointmentFragment.self, PriceFragment.self, UpcomingAppointmentFragment.self, FinalizedAppointmentFragment.self, LocationFragment.self, AddressFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self]
      ))

    var page: OpaqueCursorPage

    init(page: OpaqueCursorPage) {
      self.page = page
    }

    var __variables: Variables? { ["page": page] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("upcomingAppointments", UpcomingAppointments.self, arguments: ["page": .variable("page")]),
      ] }

      var upcomingAppointments: UpcomingAppointments { __data["upcomingAppointments"] }

      /// UpcomingAppointments
      ///
      /// Parent Type: `AppointmentsPage`
      struct UpcomingAppointments: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentsPage }
        static var __selections: [Apollo.Selection] { [
          .field("hasMore", Bool.self),
          .field("nextCursor", String?.self),
          .field("data", [Datum].self),
        ] }

        var hasMore: Bool { __data["hasMore"] }
        var nextCursor: String? { __data["nextCursor"] }
        var data: [Datum] { __data["data"] }

        /// UpcomingAppointments.Datum
        ///
        /// Parent Type: `Appointment`
        struct Datum: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.Appointment }
          static var __selections: [Apollo.Selection] { [
            .fragment(AppointmentFragment.self),
          ] }

          var id: GQL.UUID { __data["id"] }
          var scheduledAt: GQL.DateTime { __data["scheduledAt"] }
          var provider: Provider { __data["provider"] }
          var state: State { __data["state"] }
          var location: AppointmentFragment.Location { __data["location"] }
          var price: Price? { __data["price"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            var appointmentFragment: AppointmentFragment { _toFragment() }
          }

          /// UpcomingAppointments.Datum.Provider
          ///
          /// Parent Type: `Provider`
          struct Provider: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.Provider }

            var id: GQL.UUID { __data["id"] }
            var prefix: String? { __data["prefix"] }
            var firstName: String { __data["firstName"] }
            var lastName: String { __data["lastName"] }
            var title: String? { __data["title"] }
            var avatarUrl: ProviderFragment.AvatarUrl? { __data["avatarUrl"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var providerFragment: ProviderFragment { _toFragment() }
            }
          }

          /// UpcomingAppointments.Datum.State
          ///
          /// Parent Type: `AppointmentState`
          struct State: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Unions.AppointmentState }

            var asPendingAppointment: AsPendingAppointment? { _asInlineFragment() }
            var asUpcomingAppointment: AsUpcomingAppointment? { _asInlineFragment() }
            var asFinalizedAppointment: AsFinalizedAppointment? { _asInlineFragment() }

            /// UpcomingAppointments.Datum.State.AsPendingAppointment
            ///
            /// Parent Type: `PendingAppointment`
            struct AsPendingAppointment: GQL.InlineFragment {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.PendingAppointment }

              var schedulingPaymentRequirement: PendingAppointmentFragment.SchedulingPaymentRequirement? { __data["schedulingPaymentRequirement"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var pendingAppointmentFragment: PendingAppointmentFragment { _toFragment() }
              }
            }

            /// UpcomingAppointments.Datum.State.AsUpcomingAppointment
            ///
            /// Parent Type: `UpcomingAppointment`
            struct AsUpcomingAppointment: GQL.InlineFragment {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.UpcomingAppointment }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var upcomingAppointmentFragment: UpcomingAppointmentFragment { _toFragment() }
              }
            }

            /// UpcomingAppointments.Datum.State.AsFinalizedAppointment
            ///
            /// Parent Type: `FinalizedAppointment`
            struct AsFinalizedAppointment: GQL.InlineFragment {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.FinalizedAppointment }

              var `_`: GraphQLEnum<GQL.EmptyObject> { __data["_"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var finalizedAppointmentFragment: FinalizedAppointmentFragment { _toFragment() }
              }
            }
          }

          /// UpcomingAppointments.Datum.Price
          ///
          /// Parent Type: `Price`
          struct Price: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.Price }

            var amount: GQL.BigDecimal { __data["amount"] }
            var currencyCode: String { __data["currencyCode"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var priceFragment: PriceFragment { _toFragment() }
            }
          }
        }
      }
    }
  }

}