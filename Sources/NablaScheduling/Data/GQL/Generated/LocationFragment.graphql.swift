// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct LocationFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment LocationFragment on AppointmentLocation {
        __typename
        ... on PhysicalAppointmentLocation {
          __typename
          address {
            __typename
            ...AddressFragment
          }
        }
        ... on RemoteAppointmentLocation {
          __typename
          livekitRoom {
            __typename
            ...LivekitRoomFragment
          }
          externalCallUrl
        }
      }
      """

     static let possibleTypes: [String] = ["PhysicalAppointmentLocation", "RemoteAppointmentLocation"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLTypeCase(
          variants: ["PhysicalAppointmentLocation": AsPhysicalAppointmentLocation.selections, "RemoteAppointmentLocation": AsRemoteAppointmentLocation.selections],
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

     static func makePhysicalAppointmentLocation(address: AsPhysicalAppointmentLocation.Address) -> LocationFragment {
      return LocationFragment(unsafeResultMap: ["__typename": "PhysicalAppointmentLocation", "address": address.resultMap])
    }

     static func makeRemoteAppointmentLocation(livekitRoom: AsRemoteAppointmentLocation.LivekitRoom? = nil, externalCallUrl: String? = nil) -> LocationFragment {
      return LocationFragment(unsafeResultMap: ["__typename": "RemoteAppointmentLocation", "livekitRoom": livekitRoom.flatMap { (value: AsRemoteAppointmentLocation.LivekitRoom) -> ResultMap in value.resultMap }, "externalCallUrl": externalCallUrl])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var asPhysicalAppointmentLocation: AsPhysicalAppointmentLocation? {
      get {
        if !AsPhysicalAppointmentLocation.possibleTypes.contains(__typename) { return nil }
        return AsPhysicalAppointmentLocation(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsPhysicalAppointmentLocation: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["PhysicalAppointmentLocation"]

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
        self.init(unsafeResultMap: ["__typename": "PhysicalAppointmentLocation", "address": address.resultMap])
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

     var asRemoteAppointmentLocation: AsRemoteAppointmentLocation? {
      get {
        if !AsRemoteAppointmentLocation.possibleTypes.contains(__typename) { return nil }
        return AsRemoteAppointmentLocation(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsRemoteAppointmentLocation: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["RemoteAppointmentLocation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("livekitRoom", type: .object(LivekitRoom.selections)),
          GraphQLField("externalCallUrl", type: .scalar(String.self)),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(livekitRoom: LivekitRoom? = nil, externalCallUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "RemoteAppointmentLocation", "livekitRoom": livekitRoom.flatMap { (value: LivekitRoom) -> ResultMap in value.resultMap }, "externalCallUrl": externalCallUrl])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var livekitRoom: LivekitRoom? {
        get {
          return (resultMap["livekitRoom"] as? ResultMap).flatMap { LivekitRoom(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "livekitRoom")
        }
      }

       var externalCallUrl: String? {
        get {
          return resultMap["externalCallUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "externalCallUrl")
        }
      }

       struct LivekitRoom: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["LivekitRoom"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(LivekitRoomFragment.self),
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

           var livekitRoomFragment: LivekitRoomFragment {
            get {
              return LivekitRoomFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}
