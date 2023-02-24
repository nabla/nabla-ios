// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class DeleteMessageMutation: GraphQLMutation {
    static let operationName: String = "DeleteMessage"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation DeleteMessage($messageId: UUID!) {
          deleteMessage(id: $messageId) {
            __typename
            message {
              __typename
              id
              content {
                __typename
                ...MessageContentFragment
              }
            }
          }
        }
        """#,
        fragments: [MessageContentFragment.self, TextMessageContentFragment.self, ImageMessageContentFragment.self, VideoMessageContentFragment.self, DocumentMessageContentFragment.self, AudioMessageContentFragment.self, EphemeralUrlFragment.self, LivekitRoomMessageContentFragment.self, LivekitRoomFragment.self, LivekitRoomOpenStatusFragment.self, LivekitRoomClosedStatusFragment.self]
      ))

    var messageId: UUID

    init(messageId: UUID) {
      self.messageId = messageId
    }

    var __variables: Variables? { ["messageId": messageId] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("deleteMessage", DeleteMessage.self, arguments: ["id": .variable("messageId")]),
      ] }

      var deleteMessage: DeleteMessage { __data["deleteMessage"] }

      /// DeleteMessage
      ///
      /// Parent Type: `DeleteMessageOutput`
      struct DeleteMessage: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.DeleteMessageOutput }
        static var __selections: [Apollo.Selection] { [
          .field("message", Message.self),
        ] }

        var message: Message { __data["message"] }

        /// DeleteMessage.Message
        ///
        /// Parent Type: `Message`
        struct Message: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.Message }
          static var __selections: [Apollo.Selection] { [
            .field("id", GQL.UUID.self),
            .field("content", Content.self),
          ] }

          var id: GQL.UUID { __data["id"] }
          var content: Content { __data["content"] }

          /// DeleteMessage.Message.Content
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

            /// DeleteMessage.Message.Content.AsTextMessageContent
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

            /// DeleteMessage.Message.Content.AsImageMessageContent
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

            /// DeleteMessage.Message.Content.AsVideoMessageContent
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

            /// DeleteMessage.Message.Content.AsDocumentMessageContent
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

            /// DeleteMessage.Message.Content.AsAudioMessageContent
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

            /// DeleteMessage.Message.Content.AsDeletedMessageContent
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

            /// DeleteMessage.Message.Content.AsLivekitRoomMessageContent
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

              /// DeleteMessage.Message.Content.AsLivekitRoomMessageContent.LivekitRoom
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

                /// DeleteMessage.Message.Content.AsLivekitRoomMessageContent.LivekitRoom.Status
                ///
                /// Parent Type: `LivekitRoomStatus`
                struct Status: GQL.SelectionSet {
                  let __data: DataDict
                  init(data: DataDict) { __data = data }

                  static var __parentType: Apollo.ParentType { GQL.Unions.LivekitRoomStatus }

                  var asLivekitRoomOpenStatus: AsLivekitRoomOpenStatus? { _asInlineFragment() }
                  var asLivekitRoomClosedStatus: AsLivekitRoomClosedStatus? { _asInlineFragment() }

                  /// DeleteMessage.Message.Content.AsLivekitRoomMessageContent.LivekitRoom.Status.AsLivekitRoomOpenStatus
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

                  /// DeleteMessage.Message.Content.AsLivekitRoomMessageContent.LivekitRoom.Status.AsLivekitRoomClosedStatus
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
      }
    }
  }

}