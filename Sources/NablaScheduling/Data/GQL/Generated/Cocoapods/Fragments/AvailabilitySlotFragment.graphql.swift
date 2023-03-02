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
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.AvailabilitySlot }
    static var __selections: [Apollo.Selection] { [
      .field("startAt", GQL.DateTime.self),
      .field("endAt", GQL.DateTime.self),
      .field("provider", Provider.self),
    ] }

    var startAt: GQL.DateTime { __data["startAt"] }
    var endAt: GQL.DateTime { __data["endAt"] }
    var provider: Provider { __data["provider"] }

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
  }

}