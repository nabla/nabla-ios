// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct AppointmentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment AppointmentFragment on Appointment {
        __typename
        id
        scheduledAt
        provider {
          __typename
          ...ProviderFragment
        }
        state {
          __typename
          ... on PendingAppointment {
            ...PendingAppointmentFragment
          }
          ... on UpcomingAppointment {
            ...ScheduledAppointmentFragment
          }
          ... on FinalizedAppointment {
            ...FinalizedAppointmentFragment
          }
        }
        location {
          __typename
          ...LocationFragment
        }
        price {
          __typename
          ...PriceFragment
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.Appointment }
    static var __selections: [Apollo.Selection] { [
      .field("id", GQL.UUID.self),
      .field("scheduledAt", GQL.DateTime.self),
      .field("provider", Provider.self),
      .field("state", State.self),
      .field("location", Location.self),
      .field("price", Price?.self),
    ] }

    var id: GQL.UUID { __data["id"] }
    var scheduledAt: GQL.DateTime { __data["scheduledAt"] }
    var provider: Provider { __data["provider"] }
    var state: State { __data["state"] }
    var location: Location { __data["location"] }
    var price: Price? { __data["price"] }

    /// Provider
    ///
    /// Parent Type: `Provider`
    struct Provider: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Provider }
      static var __selections: [Apollo.Selection] { [
        .fragment(ProviderFragment.self),
      ] }

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

    /// State
    ///
    /// Parent Type: `AppointmentState`
    struct State: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Unions.AppointmentState }
      static var __selections: [Apollo.Selection] { [
        .inlineFragment(AsPendingAppointment.self),
        .inlineFragment(AsUpcomingAppointment.self),
        .inlineFragment(AsFinalizedAppointment.self),
      ] }

      var asPendingAppointment: AsPendingAppointment? { _asInlineFragment() }
      var asUpcomingAppointment: AsUpcomingAppointment? { _asInlineFragment() }
      var asFinalizedAppointment: AsFinalizedAppointment? { _asInlineFragment() }

      /// State.AsPendingAppointment
      ///
      /// Parent Type: `PendingAppointment`
      struct AsPendingAppointment: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.PendingAppointment }
        static var __selections: [Apollo.Selection] { [
          .fragment(PendingAppointmentFragment.self),
        ] }

        var schedulingPaymentRequirement: PendingAppointmentFragment.SchedulingPaymentRequirement? { __data["schedulingPaymentRequirement"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var pendingAppointmentFragment: PendingAppointmentFragment { _toFragment() }
        }
      }

      /// State.AsUpcomingAppointment
      ///
      /// Parent Type: `UpcomingAppointment`
      struct AsUpcomingAppointment: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.UpcomingAppointment }
        static var __selections: [Apollo.Selection] { [
          .fragment(ScheduledAppointmentFragment.self),
        ] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var scheduledAppointmentFragment: ScheduledAppointmentFragment { _toFragment() }
        }
      }

      /// State.AsFinalizedAppointment
      ///
      /// Parent Type: `FinalizedAppointment`
      struct AsFinalizedAppointment: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.FinalizedAppointment }
        static var __selections: [Apollo.Selection] { [
          .fragment(FinalizedAppointmentFragment.self),
        ] }

        var `_`: GraphQLEnum<GQL.EmptyObject> { __data["_"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var finalizedAppointmentFragment: FinalizedAppointmentFragment { _toFragment() }
        }
      }
    }

    /// Location
    ///
    /// Parent Type: `AppointmentLocation`
    struct Location: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Unions.AppointmentLocation }
      static var __selections: [Apollo.Selection] { [
        .fragment(LocationFragment.self),
      ] }

      var asPhysicalAppointmentLocation: AsPhysicalAppointmentLocation? { _asInlineFragment() }
      var asRemoteAppointmentLocation: AsRemoteAppointmentLocation? { _asInlineFragment() }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var locationFragment: LocationFragment { _toFragment() }
      }

      /// Location.AsPhysicalAppointmentLocation
      ///
      /// Parent Type: `PhysicalAppointmentLocation`
      struct AsPhysicalAppointmentLocation: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.PhysicalAppointmentLocation }

        var address: Address { __data["address"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var locationFragment: LocationFragment { _toFragment() }
        }

        /// Location.AsPhysicalAppointmentLocation.Address
        ///
        /// Parent Type: `Address`
        struct Address: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.Address }

          var id: GQL.UUID { __data["id"] }
          var address: String { __data["address"] }
          var zipCode: String { __data["zipCode"] }
          var city: String { __data["city"] }
          var state: String? { __data["state"] }
          var country: String? { __data["country"] }
          var extraDetails: String? { __data["extraDetails"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            var addressFragment: AddressFragment { _toFragment() }
          }
        }
      }

      /// Location.AsRemoteAppointmentLocation
      ///
      /// Parent Type: `RemoteAppointmentLocation`
      struct AsRemoteAppointmentLocation: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.RemoteAppointmentLocation }

        var livekitRoom: LivekitRoom? { __data["livekitRoom"] }
        var externalCallUrl: String? { __data["externalCallUrl"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var locationFragment: LocationFragment { _toFragment() }
        }

        /// Location.AsRemoteAppointmentLocation.LivekitRoom
        ///
        /// Parent Type: `LivekitRoom`
        struct LivekitRoom: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoom }

          var uuid: GQL.UUID { __data["uuid"] }
          var status: Status { __data["status"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            var livekitRoomFragment: LivekitRoomFragment { _toFragment() }
          }

          /// Location.AsRemoteAppointmentLocation.LivekitRoom.Status
          ///
          /// Parent Type: `LivekitRoomStatus`
          struct Status: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Unions.LivekitRoomStatus }

            var asLivekitRoomOpenStatus: AsLivekitRoomOpenStatus? { _asInlineFragment() }
            var asLivekitRoomClosedStatus: AsLivekitRoomClosedStatus? { _asInlineFragment() }

            /// Location.AsRemoteAppointmentLocation.LivekitRoom.Status.AsLivekitRoomOpenStatus
            ///
            /// Parent Type: `LivekitRoomOpenStatus`
            struct AsLivekitRoomOpenStatus: GQL.InlineFragment {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoomOpenStatus }

              var url: String { __data["url"] }
              var token: String { __data["token"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var livekitRoomOpenStatusFragment: LivekitRoomOpenStatusFragment { _toFragment() }
              }
            }

            /// Location.AsRemoteAppointmentLocation.LivekitRoom.Status.AsLivekitRoomClosedStatus
            ///
            /// Parent Type: `LivekitRoomClosedStatus`
            struct AsLivekitRoomClosedStatus: GQL.InlineFragment {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoomClosedStatus }

              var `_`: GraphQLEnum<GQL.EmptyObject> { __data["_"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(data: DataDict) { __data = data }

                var livekitRoomClosedStatusFragment: LivekitRoomClosedStatusFragment { _toFragment() }
              }
            }
          }
        }
      }
    }

    /// Price
    ///
    /// Parent Type: `Price`
    struct Price: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Price }
      static var __selections: [Apollo.Selection] { [
        .fragment(PriceFragment.self),
      ] }

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