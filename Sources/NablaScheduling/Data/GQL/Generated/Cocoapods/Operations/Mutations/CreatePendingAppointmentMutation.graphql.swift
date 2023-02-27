// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class CreatePendingAppointmentMutation: GraphQLMutation {
    static let operationName: String = "createPendingAppointment"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation createPendingAppointment($isPhysical: Boolean!, $categoryId: UUID!, $providerId: UUID!, $startAt: DateTime!) {
          createPendingAppointment(
            categoryId: $categoryId
            providerId: $providerId
            isPhysical: $isPhysical
            startAt: $startAt
          ) {
            __typename
            appointment {
              __typename
              ...AppointmentFragment
            }
          }
        }
        """#,
        fragments: [AppointmentFragment.self, ProviderFragment.self, PendingAppointmentFragment.self, PriceFragment.self, UpcomingAppointmentFragment.self, FinalizedAppointmentFragment.self, LocationFragment.self, AddressFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self]
      ))

    var isPhysical: Bool
    var categoryId: UUID
    var providerId: UUID
    var startAt: DateTime

    init(
      isPhysical: Bool,
      categoryId: UUID,
      providerId: UUID,
      startAt: DateTime
    ) {
      self.isPhysical = isPhysical
      self.categoryId = categoryId
      self.providerId = providerId
      self.startAt = startAt
    }

    var __variables: Variables? { [
      "isPhysical": isPhysical,
      "categoryId": categoryId,
      "providerId": providerId,
      "startAt": startAt
    ] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("createPendingAppointment", CreatePendingAppointment.self, arguments: [
          "categoryId": .variable("categoryId"),
          "providerId": .variable("providerId"),
          "isPhysical": .variable("isPhysical"),
          "startAt": .variable("startAt")
        ]),
      ] }

      var createPendingAppointment: CreatePendingAppointment { __data["createPendingAppointment"] }

      /// CreatePendingAppointment
      ///
      /// Parent Type: `ScheduleAppointmentOutput`
      struct CreatePendingAppointment: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.ScheduleAppointmentOutput }
        static var __selections: [Apollo.Selection] { [
          .field("appointment", Appointment.self),
        ] }

        var appointment: Appointment { __data["appointment"] }

        /// CreatePendingAppointment.Appointment
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

          /// CreatePendingAppointment.Appointment.Provider
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

          /// CreatePendingAppointment.Appointment.State
          ///
          /// Parent Type: `AppointmentState`
          struct State: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Unions.AppointmentState }

            var asPendingAppointment: AsPendingAppointment? { _asInlineFragment() }
            var asUpcomingAppointment: AsUpcomingAppointment? { _asInlineFragment() }
            var asFinalizedAppointment: AsFinalizedAppointment? { _asInlineFragment() }

            /// CreatePendingAppointment.Appointment.State.AsPendingAppointment
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

            /// CreatePendingAppointment.Appointment.State.AsUpcomingAppointment
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

            /// CreatePendingAppointment.Appointment.State.AsFinalizedAppointment
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

          /// CreatePendingAppointment.Appointment.Price
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