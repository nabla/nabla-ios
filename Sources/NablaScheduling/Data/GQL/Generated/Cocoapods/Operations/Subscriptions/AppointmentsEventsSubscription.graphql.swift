// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class AppointmentsEventsSubscription: GraphQLSubscription {
    static let operationName: String = "AppointmentsEvents"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        subscription AppointmentsEvents {
          appointments {
            __typename
            event {
              __typename
              ... on SubscriptionReadinessEvent {
                isReady
              }
              ... on AppointmentCreatedEvent {
                appointment {
                  __typename
                  ...AppointmentFragment
                }
              }
              ... on AppointmentUpdatedEvent {
                appointment {
                  __typename
                  ...AppointmentFragment
                }
              }
              ... on AppointmentCancelledEvent {
                appointmentId
              }
            }
          }
        }
        """#,
        fragments: [AppointmentFragment.self, ProviderFragment.self, PendingAppointmentFragment.self, PriceFragment.self, UpcomingAppointmentFragment.self, FinalizedAppointmentFragment.self, LocationFragment.self, AddressFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self]
      ))

    init() {}

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Subscription }
      static var __selections: [Apollo.Selection] { [
        .field("appointments", Appointments?.self),
      ] }

      var appointments: Appointments? { __data["appointments"] }

      /// Appointments
      ///
      /// Parent Type: `AppointmentsEventOutput`
      struct Appointments: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentsEventOutput }
        static var __selections: [Apollo.Selection] { [
          .field("event", Event.self),
        ] }

        var event: Event { __data["event"] }

        /// Appointments.Event
        ///
        /// Parent Type: `AppointmentsEvent`
        struct Event: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Unions.AppointmentsEvent }
          static var __selections: [Apollo.Selection] { [
            .inlineFragment(AsSubscriptionReadinessEvent.self),
            .inlineFragment(AsAppointmentCreatedEvent.self),
            .inlineFragment(AsAppointmentUpdatedEvent.self),
            .inlineFragment(AsAppointmentCancelledEvent.self),
          ] }

          var asSubscriptionReadinessEvent: AsSubscriptionReadinessEvent? { _asInlineFragment() }
          var asAppointmentCreatedEvent: AsAppointmentCreatedEvent? { _asInlineFragment() }
          var asAppointmentUpdatedEvent: AsAppointmentUpdatedEvent? { _asInlineFragment() }
          var asAppointmentCancelledEvent: AsAppointmentCancelledEvent? { _asInlineFragment() }

          /// Appointments.Event.AsSubscriptionReadinessEvent
          ///
          /// Parent Type: `SubscriptionReadinessEvent`
          struct AsSubscriptionReadinessEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.SubscriptionReadinessEvent }
            static var __selections: [Apollo.Selection] { [
              .field("isReady", Bool.self),
            ] }

            var isReady: Bool { __data["isReady"] }
          }

          /// Appointments.Event.AsAppointmentCreatedEvent
          ///
          /// Parent Type: `AppointmentCreatedEvent`
          struct AsAppointmentCreatedEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentCreatedEvent }
            static var __selections: [Apollo.Selection] { [
              .field("appointment", Appointment.self),
            ] }

            var appointment: Appointment { __data["appointment"] }

            /// Appointments.Event.AsAppointmentCreatedEvent.Appointment
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

              /// Appointments.Event.AsAppointmentCreatedEvent.Appointment.Provider
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

              /// Appointments.Event.AsAppointmentCreatedEvent.Appointment.State
              ///
              /// Parent Type: `AppointmentState`
              struct State: GQL.SelectionSet {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: Apollo.ParentType { GQL.Unions.AppointmentState }

                var asPendingAppointment: AsPendingAppointment? { _asInlineFragment() }
                var asUpcomingAppointment: AsUpcomingAppointment? { _asInlineFragment() }
                var asFinalizedAppointment: AsFinalizedAppointment? { _asInlineFragment() }

                /// Appointments.Event.AsAppointmentCreatedEvent.Appointment.State.AsPendingAppointment
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

                /// Appointments.Event.AsAppointmentCreatedEvent.Appointment.State.AsUpcomingAppointment
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

                /// Appointments.Event.AsAppointmentCreatedEvent.Appointment.State.AsFinalizedAppointment
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

              /// Appointments.Event.AsAppointmentCreatedEvent.Appointment.Price
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

          /// Appointments.Event.AsAppointmentUpdatedEvent
          ///
          /// Parent Type: `AppointmentUpdatedEvent`
          struct AsAppointmentUpdatedEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentUpdatedEvent }
            static var __selections: [Apollo.Selection] { [
              .field("appointment", Appointment.self),
            ] }

            var appointment: Appointment { __data["appointment"] }

            /// Appointments.Event.AsAppointmentUpdatedEvent.Appointment
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

              /// Appointments.Event.AsAppointmentUpdatedEvent.Appointment.Provider
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

              /// Appointments.Event.AsAppointmentUpdatedEvent.Appointment.State
              ///
              /// Parent Type: `AppointmentState`
              struct State: GQL.SelectionSet {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: Apollo.ParentType { GQL.Unions.AppointmentState }

                var asPendingAppointment: AsPendingAppointment? { _asInlineFragment() }
                var asUpcomingAppointment: AsUpcomingAppointment? { _asInlineFragment() }
                var asFinalizedAppointment: AsFinalizedAppointment? { _asInlineFragment() }

                /// Appointments.Event.AsAppointmentUpdatedEvent.Appointment.State.AsPendingAppointment
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

                /// Appointments.Event.AsAppointmentUpdatedEvent.Appointment.State.AsUpcomingAppointment
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

                /// Appointments.Event.AsAppointmentUpdatedEvent.Appointment.State.AsFinalizedAppointment
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

              /// Appointments.Event.AsAppointmentUpdatedEvent.Appointment.Price
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

          /// Appointments.Event.AsAppointmentCancelledEvent
          ///
          /// Parent Type: `AppointmentCancelledEvent`
          struct AsAppointmentCancelledEvent: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentCancelledEvent }
            static var __selections: [Apollo.Selection] { [
              .field("appointmentId", GQL.UUID.self),
            ] }

            var appointmentId: GQL.UUID { __data["appointmentId"] }
          }
        }
      }
    }
  }

}