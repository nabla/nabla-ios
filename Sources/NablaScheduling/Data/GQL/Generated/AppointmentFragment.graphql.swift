// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct UpcomingAppointmentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment UpcomingAppointmentFragment on UpcomingAppointment {
        __typename
        livekitRoom {
          __typename
          ...LivekitRoomFragment
        }
      }
      """

     static let possibleTypes: [String] = ["UpcomingAppointment"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("livekitRoom", type: .object(LivekitRoom.selections)),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(livekitRoom: LivekitRoom? = nil) {
      self.init(unsafeResultMap: ["__typename": "UpcomingAppointment", "livekitRoom": livekitRoom.flatMap { (value: LivekitRoom) -> ResultMap in value.resultMap }])
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
        GraphQLField("_", type: .nonNull(.scalar(EmptyObject.self))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(`_`: EmptyObject) {
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

     var `_`: EmptyObject {
      get {
        return resultMap["_"]! as! EmptyObject
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
          ... on UpcomingAppointment {
            __typename
            ...UpcomingAppointmentFragment
          }
          ... on FinalizedAppointment {
            __typename
            ...FinalizedAppointmentFragment
          }
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
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(id: GQL.UUID, scheduledAt: GQL.DateTime, provider: Provider, state: State) {
      self.init(unsafeResultMap: ["__typename": "Appointment", "id": id, "scheduledAt": scheduledAt, "provider": provider.resultMap, "state": state.resultMap])
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
       static let possibleTypes: [String] = ["UpcomingAppointment", "FinalizedAppointment"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLTypeCase(
            variants: ["UpcomingAppointment": AsUpcomingAppointment.selections, "FinalizedAppointment": AsFinalizedAppointment.selections],
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

       static func makeFinalizedAppointment(`_`: EmptyObject) -> State {
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
            GraphQLFragmentSpread(UpcomingAppointmentFragment.self),
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

           var upcomingAppointmentFragment: UpcomingAppointmentFragment {
            get {
              return UpcomingAppointmentFragment(unsafeResultMap: resultMap)
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

         init(`_`: EmptyObject) {
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
  }
}
