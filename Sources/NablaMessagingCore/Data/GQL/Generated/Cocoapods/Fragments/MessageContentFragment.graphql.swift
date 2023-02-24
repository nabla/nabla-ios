// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct MessageContentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment MessageContentFragment on MessageContent {
        __typename
        ... on TextMessageContent {
          ...TextMessageContentFragment
        }
        ... on ImageMessageContent {
          ...ImageMessageContentFragment
        }
        ... on VideoMessageContent {
          ...VideoMessageContentFragment
        }
        ... on DocumentMessageContent {
          ...DocumentMessageContentFragment
        }
        ... on AudioMessageContent {
          ...AudioMessageContentFragment
        }
        ... on DeletedMessageContent {
          empty: _
        }
        ... on LivekitRoomMessageContent {
          ...LivekitRoomMessageContentFragment
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Unions.MessageContent }
    static var __selections: [Apollo.Selection] { [
      .inlineFragment(AsTextMessageContent.self),
      .inlineFragment(AsImageMessageContent.self),
      .inlineFragment(AsVideoMessageContent.self),
      .inlineFragment(AsDocumentMessageContent.self),
      .inlineFragment(AsAudioMessageContent.self),
      .inlineFragment(AsDeletedMessageContent.self),
      .inlineFragment(AsLivekitRoomMessageContent.self),
    ] }

    var asTextMessageContent: AsTextMessageContent? { _asInlineFragment() }
    var asImageMessageContent: AsImageMessageContent? { _asInlineFragment() }
    var asVideoMessageContent: AsVideoMessageContent? { _asInlineFragment() }
    var asDocumentMessageContent: AsDocumentMessageContent? { _asInlineFragment() }
    var asAudioMessageContent: AsAudioMessageContent? { _asInlineFragment() }
    var asDeletedMessageContent: AsDeletedMessageContent? { _asInlineFragment() }
    var asLivekitRoomMessageContent: AsLivekitRoomMessageContent? { _asInlineFragment() }

    /// AsTextMessageContent
    ///
    /// Parent Type: `TextMessageContent`
    struct AsTextMessageContent: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.TextMessageContent }
      static var __selections: [Apollo.Selection] { [
        .fragment(TextMessageContentFragment.self),
      ] }

      var text: String { __data["text"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var textMessageContentFragment: TextMessageContentFragment { _toFragment() }
      }
    }

    /// AsImageMessageContent
    ///
    /// Parent Type: `ImageMessageContent`
    struct AsImageMessageContent: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.ImageMessageContent }
      static var __selections: [Apollo.Selection] { [
        .fragment(ImageMessageContentFragment.self),
      ] }

      var imageFileUpload: ImageMessageContentFragment.ImageFileUpload { __data["imageFileUpload"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var imageMessageContentFragment: ImageMessageContentFragment { _toFragment() }
      }
    }

    /// AsVideoMessageContent
    ///
    /// Parent Type: `VideoMessageContent`
    struct AsVideoMessageContent: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.VideoMessageContent }
      static var __selections: [Apollo.Selection] { [
        .fragment(VideoMessageContentFragment.self),
      ] }

      var videoFileUpload: VideoMessageContentFragment.VideoFileUpload { __data["videoFileUpload"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var videoMessageContentFragment: VideoMessageContentFragment { _toFragment() }
      }
    }

    /// AsDocumentMessageContent
    ///
    /// Parent Type: `DocumentMessageContent`
    struct AsDocumentMessageContent: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.DocumentMessageContent }
      static var __selections: [Apollo.Selection] { [
        .fragment(DocumentMessageContentFragment.self),
      ] }

      var documentFileUpload: DocumentMessageContentFragment.DocumentFileUpload { __data["documentFileUpload"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var documentMessageContentFragment: DocumentMessageContentFragment { _toFragment() }
      }
    }

    /// AsAudioMessageContent
    ///
    /// Parent Type: `AudioMessageContent`
    struct AsAudioMessageContent: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.AudioMessageContent }
      static var __selections: [Apollo.Selection] { [
        .fragment(AudioMessageContentFragment.self),
      ] }

      var audioFileUpload: AudioMessageContentFragment.AudioFileUpload { __data["audioFileUpload"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var audioMessageContentFragment: AudioMessageContentFragment { _toFragment() }
      }
    }

    /// AsDeletedMessageContent
    ///
    /// Parent Type: `DeletedMessageContent`
    struct AsDeletedMessageContent: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.DeletedMessageContent }
      static var __selections: [Apollo.Selection] { [
        .field("_", alias: "empty", GraphQLEnum<GQL.EmptyObject>.self),
      ] }

      var empty: GraphQLEnum<GQL.EmptyObject> { __data["empty"] }
    }

    /// AsLivekitRoomMessageContent
    ///
    /// Parent Type: `LivekitRoomMessageContent`
    struct AsLivekitRoomMessageContent: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoomMessageContent }
      static var __selections: [Apollo.Selection] { [
        .fragment(LivekitRoomMessageContentFragment.self),
      ] }

      var livekitRoom: LivekitRoom { __data["livekitRoom"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var livekitRoomMessageContentFragment: LivekitRoomMessageContentFragment { _toFragment() }
      }

      /// AsLivekitRoomMessageContent.LivekitRoom
      ///
      /// Parent Type: `LivekitRoom`
      struct LivekitRoom: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoom }

        var uuid: GQL.UUID { __data["uuid"] }
        var status: Status { __data["status"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var livekitRoomFragment: LivekitRoomFragment { _toFragment() }
        }

        /// AsLivekitRoomMessageContent.LivekitRoom.Status
        ///
        /// Parent Type: `LivekitRoomStatus`
        struct Status: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Unions.LivekitRoomStatus }

          var asLivekitRoomOpenStatus: AsLivekitRoomOpenStatus? { _asInlineFragment() }
          var asLivekitRoomClosedStatus: AsLivekitRoomClosedStatus? { _asInlineFragment() }

          /// AsLivekitRoomMessageContent.LivekitRoom.Status.AsLivekitRoomOpenStatus
          ///
          /// Parent Type: `LivekitRoomOpenStatus`
          struct AsLivekitRoomOpenStatus: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoomOpenStatus }

            var url: String { __data["url"] }
            var token: String { __data["token"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var livekitRoomOpenStatusFragment: LivekitRoomOpenStatusFragment { _toFragment() }
            }
          }

          /// AsLivekitRoomMessageContent.LivekitRoom.Status.AsLivekitRoomClosedStatus
          ///
          /// Parent Type: `LivekitRoomClosedStatus`
          struct AsLivekitRoomClosedStatus: GQL.InlineFragment {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoomClosedStatus }

            var `_`: GraphQLEnum<GQL.EmptyObject> { __data["_"] }

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(data: DataDict) { __data = data }

              var livekitRoomClosedStatusFragment: LivekitRoomClosedStatusFragment { _toFragment() }
            }
          }
        }
      }
    }
  }

}