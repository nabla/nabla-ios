// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct MessageFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment MessageFragment on Message {
        __typename
        id
        clientId
        createdAt
        author {
          __typename
          ...MessageAuthorFragment
        }
        content {
          __typename
          ...MessageContentFragment
        }
        replyTo {
          __typename
          ...ReplyMessageFragment
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.Message }
    static var __selections: [Apollo.Selection] { [
      .field("id", GQL.UUID.self),
      .field("clientId", GQL.UUID?.self),
      .field("createdAt", GQL.DateTime.self),
      .field("author", Author.self),
      .field("content", Content.self),
      .field("replyTo", ReplyTo?.self),
    ] }

    var id: GQL.UUID { __data["id"] }
    var clientId: GQL.UUID? { __data["clientId"] }
    var createdAt: GQL.DateTime { __data["createdAt"] }
    var author: Author { __data["author"] }
    var content: Content { __data["content"] }
    var replyTo: ReplyTo? { __data["replyTo"] }

    /// Author
    ///
    /// Parent Type: `MessageAuthor`
    struct Author: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Unions.MessageAuthor }
      static var __selections: [Apollo.Selection] { [
        .fragment(MessageAuthorFragment.self),
      ] }

      var asProvider: AsProvider? { _asInlineFragment() }
      var asPatient: AsPatient? { _asInlineFragment() }
      var asSystem: AsSystem? { _asInlineFragment() }
      var asDeletedProvider: AsDeletedProvider? { _asInlineFragment() }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var messageAuthorFragment: MessageAuthorFragment { _toFragment() }
      }

      /// Author.AsProvider
      ///
      /// Parent Type: `Provider`
      struct AsProvider: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.Provider }

        var id: GQL.UUID { __data["id"] }
        var avatarUrl: AvatarUrl? { __data["avatarUrl"] }
        var prefix: String? { __data["prefix"] }
        var firstName: String { __data["firstName"] }
        var lastName: String { __data["lastName"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageAuthorFragment: MessageAuthorFragment { _toFragment() }
          var providerFragment: ProviderFragment { _toFragment() }
        }

        /// Author.AsProvider.AvatarUrl
        ///
        /// Parent Type: `EphemeralUrl`
        struct AvatarUrl: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.EphemeralUrl }

          var expiresAt: GQL.DateTime { __data["expiresAt"] }
          var url: String { __data["url"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            var ephemeralUrlFragment: EphemeralUrlFragment { _toFragment() }
          }
        }
      }

      /// Author.AsPatient
      ///
      /// Parent Type: `Patient`
      struct AsPatient: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.Patient }

        var id: GQL.UUID { __data["id"] }
        var isMe: Bool { __data["isMe"] }
        var displayName: String { __data["displayName"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageAuthorFragment: MessageAuthorFragment { _toFragment() }
          var patientFragment: PatientFragment { _toFragment() }
        }
      }

      /// Author.AsSystem
      ///
      /// Parent Type: `System`
      struct AsSystem: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.System }

        var avatar: SystemMessageFragment.Avatar? { __data["avatar"] }
        var name: String { __data["name"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageAuthorFragment: MessageAuthorFragment { _toFragment() }
          var systemMessageFragment: SystemMessageFragment { _toFragment() }
        }
      }

      /// Author.AsDeletedProvider
      ///
      /// Parent Type: `DeletedProvider`
      struct AsDeletedProvider: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.DeletedProvider }

        var empty: GraphQLEnum<GQL.EmptyObject> { __data["empty"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageAuthorFragment: MessageAuthorFragment { _toFragment() }
        }
      }
    }

    /// Content
    ///
    /// Parent Type: `MessageContent`
    struct Content: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Unions.MessageContent }
      static var __selections: [Apollo.Selection] { [
        .fragment(MessageContentFragment.self),
      ] }

      var asTextMessageContent: AsTextMessageContent? { _asInlineFragment() }
      var asImageMessageContent: AsImageMessageContent? { _asInlineFragment() }
      var asVideoMessageContent: AsVideoMessageContent? { _asInlineFragment() }
      var asDocumentMessageContent: AsDocumentMessageContent? { _asInlineFragment() }
      var asAudioMessageContent: AsAudioMessageContent? { _asInlineFragment() }
      var asDeletedMessageContent: AsDeletedMessageContent? { _asInlineFragment() }
      var asLivekitRoomMessageContent: AsLivekitRoomMessageContent? { _asInlineFragment() }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var messageContentFragment: MessageContentFragment { _toFragment() }
      }

      /// Content.AsTextMessageContent
      ///
      /// Parent Type: `TextMessageContent`
      struct AsTextMessageContent: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.TextMessageContent }

        var text: String { __data["text"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageContentFragment: MessageContentFragment { _toFragment() }
          var textMessageContentFragment: TextMessageContentFragment { _toFragment() }
        }
      }

      /// Content.AsImageMessageContent
      ///
      /// Parent Type: `ImageMessageContent`
      struct AsImageMessageContent: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.ImageMessageContent }

        var imageFileUpload: ImageMessageContentFragment.ImageFileUpload { __data["imageFileUpload"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageContentFragment: MessageContentFragment { _toFragment() }
          var imageMessageContentFragment: ImageMessageContentFragment { _toFragment() }
        }
      }

      /// Content.AsVideoMessageContent
      ///
      /// Parent Type: `VideoMessageContent`
      struct AsVideoMessageContent: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.VideoMessageContent }

        var videoFileUpload: VideoMessageContentFragment.VideoFileUpload { __data["videoFileUpload"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageContentFragment: MessageContentFragment { _toFragment() }
          var videoMessageContentFragment: VideoMessageContentFragment { _toFragment() }
        }
      }

      /// Content.AsDocumentMessageContent
      ///
      /// Parent Type: `DocumentMessageContent`
      struct AsDocumentMessageContent: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.DocumentMessageContent }

        var documentFileUpload: DocumentMessageContentFragment.DocumentFileUpload { __data["documentFileUpload"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageContentFragment: MessageContentFragment { _toFragment() }
          var documentMessageContentFragment: DocumentMessageContentFragment { _toFragment() }
        }
      }

      /// Content.AsAudioMessageContent
      ///
      /// Parent Type: `AudioMessageContent`
      struct AsAudioMessageContent: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.AudioMessageContent }

        var audioFileUpload: AudioMessageContentFragment.AudioFileUpload { __data["audioFileUpload"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageContentFragment: MessageContentFragment { _toFragment() }
          var audioMessageContentFragment: AudioMessageContentFragment { _toFragment() }
        }
      }

      /// Content.AsDeletedMessageContent
      ///
      /// Parent Type: `DeletedMessageContent`
      struct AsDeletedMessageContent: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.DeletedMessageContent }

        var empty: GraphQLEnum<GQL.EmptyObject> { __data["empty"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageContentFragment: MessageContentFragment { _toFragment() }
        }
      }

      /// Content.AsLivekitRoomMessageContent
      ///
      /// Parent Type: `LivekitRoomMessageContent`
      struct AsLivekitRoomMessageContent: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoomMessageContent }

        var livekitRoom: LivekitRoom { __data["livekitRoom"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var messageContentFragment: MessageContentFragment { _toFragment() }
          var livekitRoomMessageContentFragment: LivekitRoomMessageContentFragment { _toFragment() }
        }

        /// Content.AsLivekitRoomMessageContent.LivekitRoom
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

          /// Content.AsLivekitRoomMessageContent.LivekitRoom.Status
          ///
          /// Parent Type: `LivekitRoomStatus`
          struct Status: GQL.SelectionSet {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Unions.LivekitRoomStatus }

            var asLivekitRoomOpenStatus: AsLivekitRoomOpenStatus? { _asInlineFragment() }
            var asLivekitRoomClosedStatus: AsLivekitRoomClosedStatus? { _asInlineFragment() }

            /// Content.AsLivekitRoomMessageContent.LivekitRoom.Status.AsLivekitRoomOpenStatus
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

            /// Content.AsLivekitRoomMessageContent.LivekitRoom.Status.AsLivekitRoomClosedStatus
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

    /// ReplyTo
    ///
    /// Parent Type: `Message`
    struct ReplyTo: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Message }
      static var __selections: [Apollo.Selection] { [
        .fragment(ReplyMessageFragment.self),
      ] }

      var id: GQL.UUID { __data["id"] }
      var clientId: GQL.UUID? { __data["clientId"] }
      var createdAt: GQL.DateTime { __data["createdAt"] }
      var author: ReplyMessageFragment.Author { __data["author"] }
      var content: ReplyMessageFragment.Content { __data["content"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var replyMessageFragment: ReplyMessageFragment { _toFragment() }
      }
    }
  }

}