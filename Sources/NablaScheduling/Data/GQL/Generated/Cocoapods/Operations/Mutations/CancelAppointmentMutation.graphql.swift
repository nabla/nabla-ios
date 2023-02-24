// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class CancelAppointmentMutation: GraphQLMutation {
    static let operationName: String = "cancelAppointment"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation cancelAppointment($appointmentId: UUID!) {
          cancelAppointment(id: $appointmentId) {
            __typename
            appointmentUuid
          }
        }
        """#
      ))

    var appointmentId: UUID

    init(appointmentId: UUID) {
      self.appointmentId = appointmentId
    }

    var __variables: Variables? { ["appointmentId": appointmentId] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("cancelAppointment", CancelAppointment.self, arguments: ["id": .variable("appointmentId")]),
      ] }

      var cancelAppointment: CancelAppointment { __data["cancelAppointment"] }

      /// CancelAppointment
      ///
      /// Parent Type: `CancelAppointmentOutput`
      struct CancelAppointment: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.CancelAppointmentOutput }
        static var __selections: [Apollo.Selection] { [
          .field("appointmentUuid", GQL.UUID.self),
        ] }

        var appointmentUuid: GQL.UUID { __data["appointmentUuid"] }
      }
    }
  }

}