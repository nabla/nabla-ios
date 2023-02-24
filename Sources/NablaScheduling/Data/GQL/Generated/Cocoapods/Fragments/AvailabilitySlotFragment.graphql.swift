// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct AvailabilitySlotFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment AvailabilitySlotFragment on AvailabilitySlot {
        __typename
        startAt
        endAt
        provider {
          __typename
          id
        }
        location {
          __typename
          ... on PhysicalAvailabilitySlotLocation {
            address {
              __typename
              ...AddressFragment
            }
          }
          ... on RemoteAvailabilitySlotLocation {
            _
          }
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.AvailabilitySlot }
    static var __selections: [Apollo.Selection] { [
      .field("startAt", GQL.DateTime.self),
      .field("endAt", GQL.DateTime.self),
      .field("provider", Provider.self),
      .field("location", Location.self),
    ] }

    var startAt: GQL.DateTime { __data["startAt"] }
    var endAt: GQL.DateTime { __data["endAt"] }
    var provider: Provider { __data["provider"] }
    var location: Location { __data["location"] }

    /// Provider
    ///
    /// Parent Type: `Provider`
    struct Provider: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Provider }
      static var __selections: [Apollo.Selection] { [
        .field("id", GQL.UUID.self),
      ] }

      var id: GQL.UUID { __data["id"] }
    }

    /// Location
    ///
    /// Parent Type: `AvailabilitySlotLocation`
    struct Location: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Unions.AvailabilitySlotLocation }
      static var __selections: [Apollo.Selection] { [
        .inlineFragment(AsPhysicalAvailabilitySlotLocation.self),
        .inlineFragment(AsRemoteAvailabilitySlotLocation.self),
      ] }

      var asPhysicalAvailabilitySlotLocation: AsPhysicalAvailabilitySlotLocation? { _asInlineFragment() }
      var asRemoteAvailabilitySlotLocation: AsRemoteAvailabilitySlotLocation? { _asInlineFragment() }

      /// Location.AsPhysicalAvailabilitySlotLocation
      ///
      /// Parent Type: `PhysicalAvailabilitySlotLocation`
      struct AsPhysicalAvailabilitySlotLocation: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.PhysicalAvailabilitySlotLocation }
        static var __selections: [Apollo.Selection] { [
          .field("address", Address.self),
        ] }

        var address: Address { __data["address"] }

        /// Location.AsPhysicalAvailabilitySlotLocation.Address
        ///
        /// Parent Type: `Address`
        struct Address: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.Address }
          static var __selections: [Apollo.Selection] { [
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

      /// Location.AsRemoteAvailabilitySlotLocation
      ///
      /// Parent Type: `RemoteAvailabilitySlotLocation`
      struct AsRemoteAvailabilitySlotLocation: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.RemoteAvailabilitySlotLocation }
        static var __selections: [Apollo.Selection] { [
          .field("_", GraphQLEnum<GQL.EmptyObject>.self),
        ] }

        var `_`: GraphQLEnum<GQL.EmptyObject> { __data["_"] }
      }
    }
  }

}