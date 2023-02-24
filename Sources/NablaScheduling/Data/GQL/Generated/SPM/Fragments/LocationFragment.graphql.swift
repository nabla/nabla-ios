// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct LocationFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment LocationFragment on AppointmentLocation {
        __typename
        ... on PhysicalAppointmentLocation {
          address {
            __typename
            ...AddressFragment
          }
        }
        ... on RemoteAppointmentLocation {
          livekitRoom {
            __typename
            ...LivekitRoomFragment
          }
          externalCallUrl
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Unions.AppointmentLocation }
    static var __selections: [ApolloAPI.Selection] { [
      .inlineFragment(AsPhysicalAppointmentLocation.self),
      .inlineFragment(AsRemoteAppointmentLocation.self),
    ] }

    var asPhysicalAppointmentLocation: AsPhysicalAppointmentLocation? { _asInlineFragment() }
    var asRemoteAppointmentLocation: AsRemoteAppointmentLocation? { _asInlineFragment() }

    /// AsPhysicalAppointmentLocation
    ///
    /// Parent Type: `PhysicalAppointmentLocation`
    struct AsPhysicalAppointmentLocation: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.PhysicalAppointmentLocation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("address", Address.self),
      ] }

      var address: Address { __data["address"] }

      /// AsPhysicalAppointmentLocation.Address
      ///
      /// Parent Type: `Address`
      struct Address: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.Address }
        static var __selections: [ApolloAPI.Selection] { [
          .fragment(AddressFragment.self),
        ] }

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

    /// AsRemoteAppointmentLocation
    ///
    /// Parent Type: `RemoteAppointmentLocation`
    struct AsRemoteAppointmentLocation: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.RemoteAppointmentLocation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("livekitRoom", LivekitRoom?.self),
        .field("externalCallUrl", String?.self),
      ] }

      var livekitRoom: LivekitRoom? { __data["livekitRoom"] }
      var externalCallUrl: String? { __data["externalCallUrl"] }

      /// AsRemoteAppointmentLocation.LivekitRoom
      ///
      /// Parent Type: `LivekitRoom`
      struct LivekitRoom: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.LivekitRoom }
        static var __selections: [ApolloAPI.Selection] { [
          .fragment(LivekitRoomFragment.self),
        ] }

        var uuid: GQL.UUID { __data["uuid"] }
        var status: Status { __data["status"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var livekitRoomFragment: LivekitRoomFragment { _toFragment() }
        }

        /// AsRemoteAppointmentLocation.LivekitRoom.Status
        ///
        /// Parent Type: `LivekitRoomStatus`
        struct Status: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: ApolloAPI.ParentType { GQL.Unions.LivekitRoomStatus }

          var asLivekitRoomOpenStatus: AsLivekitRoomOpenStatus? { _asInlineFragment() }
          var asLivekitRoomClosedStatus: AsLivekitRoomClosedStatus? { _asInlineFragment() }

          /// AsRemoteAppointmentLocation.LivekitRoom.Status.AsLivekitRoomOpenStatus
          ///
          /// Parent Type: `LivekitRoomOpenStatus`
          struct AsLivekitRoomOpenStatus: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.LivekitRoomOpenStatus }

            var url: String { __data["url"] }
            var token: String { __data["token"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var livekitRoomOpenStatusFragment: LivekitRoomOpenStatusFragment { _toFragment() }
            }
          }

          /// AsRemoteAppointmentLocation.LivekitRoom.Status.AsLivekitRoomClosedStatus
          ///
          /// Parent Type: `LivekitRoomClosedStatus`
          struct AsLivekitRoomClosedStatus: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.LivekitRoomClosedStatus }

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

}