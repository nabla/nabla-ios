// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct AudioMessageContentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment AudioMessageContentFragment on AudioMessageContent {
        __typename
        audioFileUpload {
          __typename
          id
          url {
            __typename
            ...EphemeralUrlFragment
          }
          fileName
          mimeType
          durationMs
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.AudioMessageContent }
    static var __selections: [ApolloAPI.Selection] { [
      .field("audioFileUpload", AudioFileUpload.self),
    ] }

    var audioFileUpload: AudioFileUpload { __data["audioFileUpload"] }

    /// AudioFileUpload
    ///
    /// Parent Type: `AudioFileUpload`
    struct AudioFileUpload: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.AudioFileUpload }
      static var __selections: [ApolloAPI.Selection] { [
        .field("id", GQL.UUID.self),
        .field("url", Url.self),
        .field("fileName", String.self),
        .field("mimeType", String.self),
        .field("durationMs", Int?.self),
      ] }

      var id: GQL.UUID { __data["id"] }
      var url: Url { __data["url"] }
      var fileName: String { __data["fileName"] }
      var mimeType: String { __data["mimeType"] }
      var durationMs: Int? { __data["durationMs"] }

      /// AudioFileUpload.Url
      ///
      /// Parent Type: `EphemeralUrl`
      struct Url: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.EphemeralUrl }
        static var __selections: [ApolloAPI.Selection] { [
          .fragment(EphemeralUrlFragment.self),
        ] }

        var expiresAt: GQL.DateTime { __data["expiresAt"] }
        var url: String { __data["url"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var ephemeralUrlFragment: EphemeralUrlFragment { _toFragment() }
        }
      }
    }
  }

}