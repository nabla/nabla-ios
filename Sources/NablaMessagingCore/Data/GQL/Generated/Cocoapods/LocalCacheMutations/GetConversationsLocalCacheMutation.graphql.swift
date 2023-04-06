// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class GetConversationsLocalCacheMutation: LocalCacheMutation {
    static let operationType: GraphQLOperationType = .query

    var page: OpaqueCursorPage

    init(page: OpaqueCursorPage) {
      self.page = page
    }

    var __variables: GraphQLOperation.Variables? { ["page": page] }

    struct Data: GQL.MutableSelectionSet {
      var __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("conversations", Conversations.self, arguments: ["page": .variable("page")]),
      ] }

      var conversations: Conversations {
        get { __data["conversations"] }
        set { __data["conversations"] = newValue }
      }

      /// Conversations
      ///
      /// Parent Type: `ConversationsOutput`
      struct Conversations: GQL.MutableSelectionSet {
        var __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.ConversationsOutput }
        static var __selections: [Apollo.Selection] { [
          .field("conversations", [Conversation].self),
          .field("nextCursor", String?.self),
          .field("hasMore", Bool.self),
        ] }

        var conversations: [Conversation] {
          get { __data["conversations"] }
          set { __data["conversations"] = newValue }
        }
        var nextCursor: String? {
          get { __data["nextCursor"] }
          set { __data["nextCursor"] = newValue }
        }
        var hasMore: Bool {
          get { __data["hasMore"] }
          set { __data["hasMore"] = newValue }
        }

        /// Conversations.Conversation
        ///
        /// Parent Type: `Conversation`
        struct Conversation: GQL.MutableSelectionSet {
          var __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.Conversation }
          static var __selections: [Apollo.Selection] { [
            .fragment(ConversationFragment.self),
          ] }

          var id: GQL.UUID {
            get { __data["id"] }
            set { __data["id"] = newValue }
          }
          var title: String? {
            get { __data["title"] }
            set { __data["title"] = newValue }
          }
          var subtitle: String? {
            get { __data["subtitle"] }
            set { __data["subtitle"] = newValue }
          }
          var lastMessagePreview: String? {
            get { __data["lastMessagePreview"] }
            set { __data["lastMessagePreview"] = newValue }
          }
          var lastMessage: LastMessage? {
            get { __data["lastMessage"] }
            set { __data["lastMessage"] = newValue }
          }
          var unreadMessageCount: Int {
            get { __data["unreadMessageCount"] }
            set { __data["unreadMessageCount"] = newValue }
          }
          var inboxPreviewTitle: String {
            get { __data["inboxPreviewTitle"] }
            set { __data["inboxPreviewTitle"] = newValue }
          }
          var updatedAt: GQL.DateTime {
            get { __data["updatedAt"] }
            set { __data["updatedAt"] = newValue }
          }
          var pictureUrl: PictureUrl? {
            get { __data["pictureUrl"] }
            set { __data["pictureUrl"] = newValue }
          }
          var providers: [Provider] {
            get { __data["providers"] }
            set { __data["providers"] = newValue }
          }
          var isLocked: Bool {
            get { __data["isLocked"] }
            set { __data["isLocked"] = newValue }
          }

          struct Fragments: FragmentContainer {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            var conversationFragment: ConversationFragment {
              get { _toFragment() }
              _modify { var f = conversationFragment; yield &f; __data = f.__data }
              @available(*, unavailable, message: "mutate properties of the fragment instead.")
              set { preconditionFailure() }
            }
          }

          /// Conversations.Conversation.LastMessage
          ///
          /// Parent Type: `Message`
          struct LastMessage: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.Message }

            var id: GQL.UUID {
              get { __data["id"] }
              set { __data["id"] = newValue }
            }
            var clientId: GQL.UUID? {
              get { __data["clientId"] }
              set { __data["clientId"] = newValue }
            }
            var createdAt: GQL.DateTime {
              get { __data["createdAt"] }
              set { __data["createdAt"] = newValue }
            }
            var author: MessageFragment.Author {
              get { __data["author"] }
              set { __data["author"] = newValue }
            }
            var content: MessageFragment.Content {
              get { __data["content"] }
              set { __data["content"] = newValue }
            }
            var replyTo: ReplyTo? {
              get { __data["replyTo"] }
              set { __data["replyTo"] = newValue }
            }

            struct Fragments: FragmentContainer {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              var messageFragment: MessageFragment {
                get { _toFragment() }
                _modify { var f = messageFragment; yield &f; __data = f.__data }
                @available(*, unavailable, message: "mutate properties of the fragment instead.")
                set { preconditionFailure() }
              }
            }

            /// Conversations.Conversation.LastMessage.ReplyTo
            ///
            /// Parent Type: `Message`
            struct ReplyTo: GQL.MutableSelectionSet {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.Message }

              var id: GQL.UUID {
                get { __data["id"] }
                set { __data["id"] = newValue }
              }
              var clientId: GQL.UUID? {
                get { __data["clientId"] }
                set { __data["clientId"] = newValue }
              }
              var createdAt: GQL.DateTime {
                get { __data["createdAt"] }
                set { __data["createdAt"] = newValue }
              }
              var author: ReplyMessageFragment.Author {
                get { __data["author"] }
                set { __data["author"] = newValue }
              }
              var content: ReplyMessageFragment.Content {
                get { __data["content"] }
                set { __data["content"] = newValue }
              }

              struct Fragments: FragmentContainer {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                var replyMessageFragment: ReplyMessageFragment {
                  get { _toFragment() }
                  _modify { var f = replyMessageFragment; yield &f; __data = f.__data }
                  @available(*, unavailable, message: "mutate properties of the fragment instead.")
                  set { preconditionFailure() }
                }
              }
            }
          }

          /// Conversations.Conversation.PictureUrl
          ///
          /// Parent Type: `EphemeralUrl`
          struct PictureUrl: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.EphemeralUrl }

            var expiresAt: GQL.DateTime {
              get { __data["expiresAt"] }
              set { __data["expiresAt"] = newValue }
            }
            var url: String {
              get { __data["url"] }
              set { __data["url"] = newValue }
            }

            struct Fragments: FragmentContainer {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              var ephemeralUrlFragment: EphemeralUrlFragment {
                get { _toFragment() }
                _modify { var f = ephemeralUrlFragment; yield &f; __data = f.__data }
                @available(*, unavailable, message: "mutate properties of the fragment instead.")
                set { preconditionFailure() }
              }
            }
          }

          /// Conversations.Conversation.Provider
          ///
          /// Parent Type: `ProviderInConversation`
          struct Provider: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: Apollo.ParentType { GQL.Objects.ProviderInConversation }

            var id: GQL.UUID {
              get { __data["id"] }
              set { __data["id"] = newValue }
            }
            var provider: Provider {
              get { __data["provider"] }
              set { __data["provider"] = newValue }
            }
            var typingAt: GQL.DateTime? {
              get { __data["typingAt"] }
              set { __data["typingAt"] = newValue }
            }
            var seenUntil: GQL.DateTime? {
              get { __data["seenUntil"] }
              set { __data["seenUntil"] = newValue }
            }

            struct Fragments: FragmentContainer {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              var providerInConversationFragment: ProviderInConversationFragment {
                get { _toFragment() }
                _modify { var f = providerInConversationFragment; yield &f; __data = f.__data }
                @available(*, unavailable, message: "mutate properties of the fragment instead.")
                set { preconditionFailure() }
              }
            }

            /// Conversations.Conversation.Provider.Provider
            ///
            /// Parent Type: `Provider`
            struct Provider: GQL.MutableSelectionSet {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: Apollo.ParentType { GQL.Objects.Provider }

              var id: GQL.UUID {
                get { __data["id"] }
                set { __data["id"] = newValue }
              }
              var avatarUrl: AvatarUrl? {
                get { __data["avatarUrl"] }
                set { __data["avatarUrl"] = newValue }
              }
              var prefix: String? {
                get { __data["prefix"] }
                set { __data["prefix"] = newValue }
              }
              var firstName: String {
                get { __data["firstName"] }
                set { __data["firstName"] = newValue }
              }
              var lastName: String {
                get { __data["lastName"] }
                set { __data["lastName"] = newValue }
              }

              struct Fragments: FragmentContainer {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                var providerFragment: ProviderFragment {
                  get { _toFragment() }
                  _modify { var f = providerFragment; yield &f; __data = f.__data }
                  @available(*, unavailable, message: "mutate properties of the fragment instead.")
                  set { preconditionFailure() }
                }
              }

              /// Conversations.Conversation.Provider.Provider.AvatarUrl
              ///
              /// Parent Type: `EphemeralUrl`
              struct AvatarUrl: GQL.MutableSelectionSet {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: Apollo.ParentType { GQL.Objects.EphemeralUrl }

                var expiresAt: GQL.DateTime {
                  get { __data["expiresAt"] }
                  set { __data["expiresAt"] = newValue }
                }
                var url: String {
                  get { __data["url"] }
                  set { __data["url"] = newValue }
                }

                struct Fragments: FragmentContainer {
                  var __data: DataDict
                  init(data: DataDict) { __data = data }

                  var ephemeralUrlFragment: EphemeralUrlFragment {
                    get { _toFragment() }
                    _modify { var f = ephemeralUrlFragment; yield &f; __data = f.__data }
                    @available(*, unavailable, message: "mutate properties of the fragment instead.")
                    set { preconditionFailure() }
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