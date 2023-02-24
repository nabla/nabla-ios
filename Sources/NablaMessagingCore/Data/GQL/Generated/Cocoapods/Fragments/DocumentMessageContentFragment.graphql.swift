// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct DocumentMessageContentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment DocumentMessageContentFragment on DocumentMessageContent {
        __typename
        documentFileUpload {
          __typename
          id
          url {
            __typename
            url
          }
          fileName
          mimeType
          thumbnail {
            __typename
            url {
              __typename
              url
            }
          }
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.DocumentMessageContent }
    static var __selections: [Apollo.Selection] { [
      .field("documentFileUpload", DocumentFileUpload.self),
    ] }

    var documentFileUpload: DocumentFileUpload { __data["documentFileUpload"] }

    /// DocumentFileUpload
    ///
    /// Parent Type: `DocumentFileUpload`
    struct DocumentFileUpload: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.DocumentFileUpload }
      static var __selections: [Apollo.Selection] { [
        .field("id", GQL.UUID.self),
        .field("url", Url.self),
        .field("fileName", String.self),
        .field("mimeType", String.self),
        .field("thumbnail", Thumbnail?.self),
      ] }

      var id: GQL.UUID { __data["id"] }
      var url: Url { __data["url"] }
      var fileName: String { __data["fileName"] }
      var mimeType: String { __data["mimeType"] }
      var thumbnail: Thumbnail? { __data["thumbnail"] }

      /// DocumentFileUpload.Url
      ///
      /// Parent Type: `EphemeralUrl`
      struct Url: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.EphemeralUrl }
        static var __selections: [Apollo.Selection] { [
          .field("url", String.self),
        ] }

        var url: String { __data["url"] }
      }

      /// DocumentFileUpload.Thumbnail
      ///
      /// Parent Type: `ImageFileUpload`
      struct Thumbnail: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.ImageFileUpload }
        static var __selections: [Apollo.Selection] { [
          .field("url", Url.self),
        ] }

        var url: Url { __data["url"] }

        /// DocumentFileUpload.Thumbnail.Url
        ///
        /// Parent Type: `EphemeralUrl`
        struct Url: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.EphemeralUrl }
          static var __selections: [Apollo.Selection] { [
            .field("url", String.self),
          ] }

          var url: String { __data["url"] }
        }
      }
    }
  }

}