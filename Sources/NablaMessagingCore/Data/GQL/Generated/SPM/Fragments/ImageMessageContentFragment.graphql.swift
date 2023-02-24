// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct ImageMessageContentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ImageMessageContentFragment on ImageMessageContent {
        __typename
        imageFileUpload {
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

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.ImageMessageContent }
    static var __selections: [ApolloAPI.Selection] { [
      .field("imageFileUpload", ImageFileUpload.self),
    ] }

    var imageFileUpload: ImageFileUpload { __data["imageFileUpload"] }

    /// ImageFileUpload
    ///
    /// Parent Type: `ImageFileUpload`
    struct ImageFileUpload: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.ImageFileUpload }
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

      /// ImageFileUpload.Url
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