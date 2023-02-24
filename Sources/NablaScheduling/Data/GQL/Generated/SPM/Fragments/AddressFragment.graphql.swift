// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct AddressFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment AddressFragment on Address {
        __typename
        id
        address
        zipCode
        city
        state
        country
        extraDetails
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.Address }
    static var __selections: [ApolloAPI.Selection] { [
      .field("id", GQL.UUID.self),
      .field("address", String.self),
      .field("zipCode", String.self),
      .field("city", String.self),
      .field("state", String?.self),
      .field("country", String?.self),
      .field("extraDetails", String?.self),
    ] }

    var id: GQL.UUID { __data["id"] }
    var address: String { __data["address"] }
    var zipCode: String { __data["zipCode"] }
    var city: String { __data["city"] }
    var state: String? { __data["state"] }
    var country: String? { __data["country"] }
    var extraDetails: String? { __data["extraDetails"] }
  }

}