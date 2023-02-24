// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class GetAvailableLocationsQuery: GraphQLQuery {
    static let operationName: String = "GetAvailableLocations"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetAvailableLocations {
          appointmentAvailableLocations {
            __typename
            hasPhysicalAvailabilities
            hasRemoteAvailabilities
          }
        }
        """#
      ))

    init() {}

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("appointmentAvailableLocations", AppointmentAvailableLocations.self),
      ] }

      var appointmentAvailableLocations: AppointmentAvailableLocations { __data["appointmentAvailableLocations"] }

      /// AppointmentAvailableLocations
      ///
      /// Parent Type: `AppointmentAvailableLocationsOutput`
      struct AppointmentAvailableLocations: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentAvailableLocationsOutput }
        static var __selections: [Apollo.Selection] { [
          .field("hasPhysicalAvailabilities", Bool.self),
          .field("hasRemoteAvailabilities", Bool.self),
        ] }

        var hasPhysicalAvailabilities: Bool { __data["hasPhysicalAvailabilities"] }
        var hasRemoteAvailabilities: Bool { __data["hasRemoteAvailabilities"] }
      }
    }
  }

}