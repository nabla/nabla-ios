// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct PriceFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment PriceFragment on Price {
        __typename
        amount
        currencyCode
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.Price }
    static var __selections: [ApolloAPI.Selection] { [
      .field("amount", GQL.BigDecimal.self),
      .field("currencyCode", String.self),
    ] }

    var amount: GQL.BigDecimal { __data["amount"] }
    var currencyCode: String { __data["currencyCode"] }
  }

}