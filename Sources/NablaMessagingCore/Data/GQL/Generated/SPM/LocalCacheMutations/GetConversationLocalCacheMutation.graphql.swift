// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class GetConversationLocalCacheMutation: LocalCacheMutation {
    static let operationType: GraphQLOperationType = .query

    var id: UUID

    init(id: UUID) {
      self.id = id
    }

    var __variables: GraphQLOperation.Variables? { ["id": id] }

    struct Data: GQL.MutableSelectionSet {
      var __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("conversation", Conversation.self, arguments: ["id": .variable("id")]),
      ] }

      var conversation: Conversation {
        get { __data["conversation"] }
        set { __data["conversation"] = newValue }
      }

      /// Conversation
      ///
      /// Parent Type: `ConversationOutput`
      struct Conversation: GQL.MutableSelectionSet {
        var __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationOutput }
        static var __selections: [ApolloAPI.Selection] { [
          .field("conversation", Conversation.self),
        ] }

        var conversation: Conversation {
          get { __data["conversation"] }
          set { __data["conversation"] = newValue }
        }

        /// Conversation.Conversation
        ///
        /// Parent Type: `Conversation`
        struct Conversation: GQL.MutableSelectionSet {
          var __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: ApolloAPI.ParentType { GQL.Objects.Conversation }
          static var __selections: [ApolloAPI.Selection] { [
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

          /// Conversation.Conversation.PictureUrl
          ///
          /// Parent Type: `EphemeralUrl`
          struct PictureUrl: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.EphemeralUrl }

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

          /// Conversation.Conversation.Provider
          ///
          /// Parent Type: `ProviderInConversation`
          struct Provider: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.ProviderInConversation }

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

            /// Conversation.Conversation.Provider.Provider
            ///
            /// Parent Type: `Provider`
            struct Provider: GQL.MutableSelectionSet {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: ApolloAPI.ParentType { GQL.Objects.Provider }

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

              /// Conversation.Conversation.Provider.Provider.AvatarUrl
              ///
              /// Parent Type: `EphemeralUrl`
              struct AvatarUrl: GQL.MutableSelectionSet {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: ApolloAPI.ParentType { GQL.Objects.EphemeralUrl }

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