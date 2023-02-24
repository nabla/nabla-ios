// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct PendingAppointmentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment PendingAppointmentFragment on PendingAppointment {
        __typename
        schedulingPaymentRequirement {
          __typename
          price {
            __typename
            ...PriceFragment
          }
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.PendingAppointment }
    static var __selections: [ApolloAPI.Selection] { [
      .field("schedulingPaymentRequirement", SchedulingPaymentRequirement?.self),
    ] }

    var schedulingPaymentRequirement: SchedulingPaymentRequirement? { __data["schedulingPaymentRequirement"] }

    /// SchedulingPaymentRequirement
    ///
    /// Parent Type: `AppointmentSchedulingRequiresPayment`
    struct SchedulingPaymentRequirement: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.AppointmentSchedulingRequiresPayment }
      static var __selections: [ApolloAPI.Selection] { [
        .field("price", Price.self),
      ] }

      var price: Price { __data["price"] }

      /// SchedulingPaymentRequirement.Price
      ///
      /// Parent Type: `Price`
      struct Price: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.Price }
        static var __selections: [ApolloAPI.Selection] { [
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

}