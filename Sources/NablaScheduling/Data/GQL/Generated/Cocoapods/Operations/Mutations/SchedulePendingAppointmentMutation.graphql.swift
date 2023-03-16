// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class SchedulePendingAppointmentMutation: GraphQLMutation {
    static let operationName: String = "schedulePendingAppointment"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation schedulePendingAppointment($appointmentId: UUID!) {
          schedulePendingAppointment(appointmentId: $appointmentId) {
            __typename
            appointment {
              __typename
              ...AppointmentFragment
            }
          }
        }
        """#,
        fragments: [AppointmentFragment.self, ProviderFragment.self, PendingAppointmentFragment.self, PriceFragment.self, ScheduledAppointmentFragment.self, FinalizedAppointmentFragment.self, LocationFragment.self, AddressFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self]
      ))

    var appointmentId: UUID

    init(appointmentId: UUID) {
      self.appointmentId = appointmentId
    }

    var __variables: Variables? { ["appointmentId": appointmentId] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("schedulePendingAppointment", SchedulePendingAppointment.self, arguments: ["appointmentId": .variable("appointmentId")]),
      ] }

      var schedulePendingAppointment: SchedulePendingAppointment { __data["schedulePendingAppointment"] }

      /// SchedulePendingAppointment
      ///
      /// Parent Type: `ScheduleAppointmentOutput`
      struct SchedulePendingAppointment: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.ScheduleAppointmentOutput }
        static var __selections: [Apollo.Selection] { [
          .field("appointment", Appointment.self),
        ] }

        var appointment: Appointment { __data["appointment"] }

        /// SchedulePendingAppointment.Appointment
        ///
        /// Parent Type: `Appointment`
        struct Appointment: GQL.SelectionSet {
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

          /// SchedulePendingAppointment.Appointment.Provider
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

          /// SchedulePendingAppointment.Appointment.State
          ///
          /// Parent Type: `AppointmentState`
          struct State: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Unions.AppointmentState }

            var asPendingAppointment: AsPendingAppointment? { _asInlineFragment() }
            var asUpcomingAppointment: AsUpcomingAppointment? { _asInlineFragment() }
            var asFinalizedAppointment: AsFinalizedAppointment? { _asInlineFragment() }

            /// SchedulePendingAppointment.Appointment.State.AsPendingAppointment
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

            /// SchedulePendingAppointment.Appointment.State.AsUpcomingAppointment
            ///
            /// Parent Type: `UpcomingAppointment`
            struct AsUpcomingAppointment: GQL.InlineFragment {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.UpcomingAppointment }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var scheduledAppointmentFragment: ScheduledAppointmentFragment { _toFragment() }
              }
            }

            /// SchedulePendingAppointment.Appointment.State.AsFinalizedAppointment
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

          /// SchedulePendingAppointment.Appointment.Price
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