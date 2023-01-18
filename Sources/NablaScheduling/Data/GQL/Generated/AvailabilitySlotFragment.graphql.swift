// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct AvailabilitySlotFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
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
            __typename
            address {
              __typename
              ...AddressFragment
            }
          }
          ... on RemoteAvailabilitySlotLocation {
            __typename
            _
          }
        }
      }
      """

     static let possibleTypes: [String] = ["AvailabilitySlot"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("startAt", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("endAt", type: .nonNull(.scalar(GQL.DateTime.self))),
        GraphQLField("provider", type: .nonNull(.object(Provider.selections))),
        GraphQLField("location", type: .nonNull(.object(Location.selections))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(startAt: GQL.DateTime, endAt: GQL.DateTime, provider: Provider, location: Location) {
      self.init(unsafeResultMap: ["__typename": "AvailabilitySlot", "startAt": startAt, "endAt": endAt, "provider": provider.resultMap, "location": location.resultMap])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var startAt: GQL.DateTime {
      get {
        return resultMap["startAt"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "startAt")
      }
    }

     var endAt: GQL.DateTime {
      get {
        return resultMap["endAt"]! as! GQL.DateTime
      }
      set {
        resultMap.updateValue(newValue, forKey: "endAt")
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

     var location: Location {
      get {
        return Location(unsafeResultMap: resultMap["location"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "location")
      }
    }

     struct Provider: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Provider"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(id: GQL.UUID) {
        self.init(unsafeResultMap: ["__typename": "Provider", "id": id])
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
    }

     struct Location: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["PhysicalAvailabilitySlotLocation", "RemoteAvailabilitySlotLocation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLTypeCase(
            variants: ["PhysicalAvailabilitySlotLocation": AsPhysicalAvailabilitySlotLocation.selections, "RemoteAvailabilitySlotLocation": AsRemoteAvailabilitySlotLocation.selections],
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

       static func makePhysicalAvailabilitySlotLocation(address: AsPhysicalAvailabilitySlotLocation.Address) -> Location {
        return Location(unsafeResultMap: ["__typename": "PhysicalAvailabilitySlotLocation", "address": address.resultMap])
      }

       static func makeRemoteAvailabilitySlotLocation(`_`: EmptyObject) -> Location {
        return Location(unsafeResultMap: ["__typename": "RemoteAvailabilitySlotLocation", "_": `_`])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var asPhysicalAvailabilitySlotLocation: AsPhysicalAvailabilitySlotLocation? {
        get {
          if !AsPhysicalAvailabilitySlotLocation.possibleTypes.contains(__typename) { return nil }
          return AsPhysicalAvailabilitySlotLocation(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

       struct AsPhysicalAvailabilitySlotLocation: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["PhysicalAvailabilitySlotLocation"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("address", type: .nonNull(.object(Address.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(address: Address) {
          self.init(unsafeResultMap: ["__typename": "PhysicalAvailabilitySlotLocation", "address": address.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var address: Address {
          get {
            return Address(unsafeResultMap: resultMap["address"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "address")
          }
        }

         struct Address: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["Address"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(AddressFragment.self),
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           init(id: GQL.UUID, address: String, zipCode: String, city: String, state: String? = nil, country: String? = nil, extraDetails: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Address", "id": id, "address": address, "zipCode": zipCode, "city": city, "state": state, "country": country, "extraDetails": extraDetails])
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

             var addressFragment: AddressFragment {
              get {
                return AddressFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }

       var asRemoteAvailabilitySlotLocation: AsRemoteAvailabilitySlotLocation? {
        get {
          if !AsRemoteAvailabilitySlotLocation.possibleTypes.contains(__typename) { return nil }
          return AsRemoteAvailabilitySlotLocation(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

       struct AsRemoteAvailabilitySlotLocation: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["RemoteAvailabilitySlotLocation"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_", type: .nonNull(.scalar(EmptyObject.self))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(`_`: EmptyObject) {
          self.init(unsafeResultMap: ["__typename": "RemoteAvailabilitySlotLocation", "_": `_`])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var `_`: EmptyObject {
          get {
            return resultMap["_"]! as! EmptyObject
          }
          set {
            resultMap.updateValue(newValue, forKey: "_")
          }
        }
      }
    }
  }
}
