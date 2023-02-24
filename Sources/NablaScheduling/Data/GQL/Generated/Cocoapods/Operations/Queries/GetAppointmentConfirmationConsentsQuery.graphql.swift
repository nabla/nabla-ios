// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class GetAppointmentConfirmationConsentsQuery: GraphQLQuery {
    static let operationName: String = "GetAppointmentConfirmationConsents"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetAppointmentConfirmationConsents {
          appointmentConfirmationConsents {
            __typename
            firstConsentHtml
            secondConsentHtml
            physicalFirstConsentHtml
            physicalSecondConsentHtml
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
        .field("appointmentConfirmationConsents", AppointmentConfirmationConsents.self),
      ] }

      var appointmentConfirmationConsents: AppointmentConfirmationConsents { __data["appointmentConfirmationConsents"] }

      /// AppointmentConfirmationConsents
      ///
      /// Parent Type: `AppointmentConfirmationConsentsOutput`
      struct AppointmentConfirmationConsents: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.AppointmentConfirmationConsentsOutput }
        static var __selections: [Apollo.Selection] { [
          .field("firstConsentHtml", String.self),
          .field("secondConsentHtml", String.self),
          .field("physicalFirstConsentHtml", String.self),
          .field("physicalSecondConsentHtml", String.self),
        ] }

        var firstConsentHtml: String { __data["firstConsentHtml"] }
        var secondConsentHtml: String { __data["secondConsentHtml"] }
        var physicalFirstConsentHtml: String { __data["physicalFirstConsentHtml"] }
        var physicalSecondConsentHtml: String { __data["physicalSecondConsentHtml"] }
      }
    }
  }

}