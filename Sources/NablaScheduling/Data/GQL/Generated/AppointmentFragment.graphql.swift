// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct PendingAppointmentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
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
      """

     static let possibleTypes: [String] = ["PendingAppointment"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("schedulingPaymentRequirement", type: .object(SchedulingPaymentRequirement.selections)),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(schedulingPaymentRequirement: SchedulingPaymentRequirement? = nil) {
      self.init(unsafeResultMap: ["__typename": "PendingAppointment", "schedulingPaymentRequirement": schedulingPaymentRequirement.flatMap { (value: SchedulingPaymentRequirement) -> ResultMap in value.resultMap }])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var schedulingPaymentRequirement: SchedulingPaymentRequirement? {
      get {
        return (resultMap["schedulingPaymentRequirement"] as? ResultMap).flatMap { SchedulingPaymentRequirement(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "schedulingPaymentRequirement")
      }
    }

     struct SchedulingPaymentRequirement: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["AppointmentSchedulingRequiresPayment"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("price", type: .nonNull(.object(Price.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(price: Price) {
        self.init(unsafeResultMap: ["__typename": "AppointmentSchedulingRequiresPayment", "price": price.resultMap])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var price: Price {
        get {
          return Price(unsafeResultMap: resultMap["price"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "price")
        }
      }

       struct Price: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["Price"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(PriceFragment.self),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(amount: GQL.BigDecimal, currencyCode: String) {
          self.init(unsafeResultMap: ["__typename": "Price", "amount": amount, "currencyCode": currencyCode])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

         struct Fragments {
           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           var priceFragment: PriceFragment {
            get {
              return PriceFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }

  struct ScheduledAppointmentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment ScheduledAppointmentFragment on UpcomingAppointment {
        __typename
      }
      """

     static let possibleTypes: [String] = ["UpcomingAppointment"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init() {
      self.init(unsafeResultMap: ["__typename": "UpcomingAppointment"])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }
  }

  struct FinalizedAppointmentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment FinalizedAppointmentFragment on FinalizedAppointment {
        __typename
        _
      }
      """

     static let possibleTypes: [String] = ["FinalizedAppointment"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_", type: .scalar(EmptyObject.self)),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(`_`: EmptyObject? = nil) {
      self.init(unsafeResultMap: ["__typename": "FinalizedAppointment", "_": `_`])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var `_`: EmptyObject? {
      get {
        return resultMap["_"] as? EmptyObject
      }
      set {
        resultMap.updateValue(newValue, forKey: "_")
      }
    }
  }

  struct AppointmentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
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
            __typename
            ...PendingAppointmentFragment
          }
          ... on UpcomingAppointment {
            __typename
            ...ScheduledAppointmentFragment
          }
          ... on FinalizedAppointment {
            __typename
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
      """

     static let possibleTypes: [String] = ["Appointment"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        GraphQLField("scheduledAt", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("provider", type: .nonNull(.object(Provider.selections))),
        GraphQLField("state", type: .nonNull(.object(State.selections))),
        GraphQLField("location", type: .nonNull(.object(Location.selections))),
        GraphQLField("price", type: .object(Price.selections)),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(id: GQL.UUID, scheduledAt: GQL.DateTime, provider: Provider, state: State, location: Location, price: Price? = nil) {
      self.init(unsafeResultMap: ["__typename": "Appointment", "id": id, "scheduledAt": scheduledAt, "provider": provider.resultMap, "state": state.resultMap, "location": location.resultMap, "price": price.flatMap { (value: Price) -> ResultMap in value.resultMap }])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var id: GQL.UUID {
      get {
        return resultMap["id"]! as! GQL.UUID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

     var scheduledAt: GQL.DateTime {
      get {
        return resultMap["scheduledAt"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "scheduledAt")
      }
    }

     var provider: Provider {
      get {
        return Provider(unsafeResultMap: resultMap["provider"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "provider")
      }
    }

     var state: State {
      get {
        return State(unsafeResultMap: resultMap["state"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "state")
      }
    }

     var location: Location {
      get {
        return Location(unsafeResultMap: resultMap["location"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "location")
      }
    }

     var price: Price? {
      get {
        return (resultMap["price"] as? ResultMap).flatMap { Price(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "price")
      }
    }

     struct Provider: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Provider"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ProviderFragment.self),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

       struct Fragments {
         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         var providerFragment: ProviderFragment {
          get {
            return ProviderFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     struct State: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["PendingAppointment", "UpcomingAppointment", "FinalizedAppointment"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLTypeCase(
            variants: ["PendingAppointment": AsPendingAppointment.selections, "UpcomingAppointment": AsUpcomingAppointment.selections, "FinalizedAppointment": AsFinalizedAppointment.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       static func makeUpcomingAppointment() -> State {
        return State(unsafeResultMap: ["__typename": "UpcomingAppointment"])
      }

       static func makeFinalizedAppointment(`_`: EmptyObject? = nil) -> State {
        return State(unsafeResultMap: ["__typename": "FinalizedAppointment", "_": `_`])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var asPendingAppointment: AsPendingAppointment? {
        get {
          if !AsPendingAppointment.possibleTypes.contains(__typename) { return nil }
          return AsPendingAppointment(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

       struct AsPendingAppointment: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["PendingAppointment"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(PendingAppointmentFragment.self),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

         struct Fragments {
           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           var pendingAppointmentFragment: PendingAppointmentFragment {
            get {
              return PendingAppointmentFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

       var asUpcomingAppointment: AsUpcomingAppointment? {
        get {
          if !AsUpcomingAppointment.possibleTypes.contains(__typename) { return nil }
          return AsUpcomingAppointment(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

       struct AsUpcomingAppointment: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["UpcomingAppointment"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(ScheduledAppointmentFragment.self),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init() {
          self.init(unsafeResultMap: ["__typename": "UpcomingAppointment"])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

         struct Fragments {
           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           var scheduledAppointmentFragment: ScheduledAppointmentFragment {
            get {
              return ScheduledAppointmentFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

       var asFinalizedAppointment: AsFinalizedAppointment? {
        get {
          if !AsFinalizedAppointment.possibleTypes.contains(__typename) { return nil }
          return AsFinalizedAppointment(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

       struct AsFinalizedAppointment: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["FinalizedAppointment"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(FinalizedAppointmentFragment.self),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(`_`: EmptyObject? = nil) {
          self.init(unsafeResultMap: ["__typename": "FinalizedAppointment", "_": `_`])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

         struct Fragments {
           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           var finalizedAppointmentFragment: FinalizedAppointmentFragment {
            get {
              return FinalizedAppointmentFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }

     struct Location: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["PhysicalAppointmentLocation", "RemoteAppointmentLocation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(LocationFragment.self),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

       struct Fragments {
         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         var locationFragment: LocationFragment {
          get {
            return LocationFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     struct Price: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Price"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(PriceFragment.self),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(amount: GQL.BigDecimal, currencyCode: String) {
        self.init(unsafeResultMap: ["__typename": "Price", "amount": amount, "currencyCode": currencyCode])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

       struct Fragments {
         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         var priceFragment: PriceFragment {
          get {
            return PriceFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
