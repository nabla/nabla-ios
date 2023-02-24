// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct VideoMessageContentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment VideoMessageContentFragment on VideoMessageContent {
        __typename
        videoFileUpload {
          __typename
          id
          url {
            __typename
            url
          }
          fileName
          mimeType
          width
          height
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.VideoMessageContent }
    static var __selections: [ApolloAPI.Selection] { [
      .field("videoFileUpload", VideoFileUpload.self),
    ] }

    var videoFileUpload: VideoFileUpload { __data["videoFileUpload"] }

    /// VideoFileUpload
    ///
    /// Parent Type: `VideoFileUpload`
    struct VideoFileUpload: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.VideoFileUpload }
      static var __selections: [ApolloAPI.Selection] { [
        .field("id", GQL.UUID.self),
        .field("url", Url.self),
        .field("fileName", String.self),
        .field("mimeType", String.self),
        .field("width", Int?.self),
        .field("height", Int?.self),
      ] }

      var id: GQL.UUID { __data["id"] }
      var url: Url { __data["url"] }
      var fileName: String { __data["fileName"] }
      var mimeType: String { __data["mimeType"] }
      var width: Int? { __data["width"] }
      var height: Int? { __data["height"] }

      /// VideoFileUpload.Url
      ///
      /// Parent Type: `EphemeralUrl`
      struct Url: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.EphemeralUrl }
        static var __selections: [ApolloAPI.Selection] { [
          .field("url", String.self),
        ] }

        var url: String { __data["url"] }
      }
    }
  }

}