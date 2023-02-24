// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class GetConversationItemsLocalCacheMutation: LocalCacheMutation {
    static let operationType: GraphQLOperationType = .query

    var id: UUID
    var page: OpaqueCursorPage

    init(
      id: UUID,
      page: OpaqueCursorPage
    ) {
      self.id = id
      self.page = page
    }

    var __variables: GraphQLOperation.Variables? { [
      "id": id,
      "page": page
    ] }

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
            .field("id", GQL.UUID.self),
            .field("items", Items.self, arguments: ["page": .variable("page")]),
          ] }

          var id: GQL.UUID {
            get { __data["id"] }
            set { __data["id"] = newValue }
          }
          var items: Items {
            get { __data["items"] }
            set { __data["items"] = newValue }
          }

          /// Conversation.Conversation.Items
          ///
          /// Parent Type: `ConversationItemsPage`
          struct Items: GQL.MutableSelectionSet {
            var __data: DataDict
            init(data: DataDict) { __data = data }

            static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationItemsPage }
            static var __selections: [ApolloAPI.Selection] { [
              .field("hasMore", Bool.self),
              .field("nextCursor", String?.self),
              .field("data", [Datum?].self),
            ] }

            var hasMore: Bool {
              get { __data["hasMore"] }
              set { __data["hasMore"] = newValue }
            }
            var nextCursor: String? {
              get { __data["nextCursor"] }
              set { __data["nextCursor"] = newValue }
            }
            var data: [Datum?] {
              get { __data["data"] }
              set { __data["data"] = newValue }
            }

            /// Conversation.Conversation.Items.Datum
            ///
            /// Parent Type: `ConversationItem`
            struct Datum: GQL.MutableSelectionSet {
              var __data: DataDict
              init(data: DataDict) { __data = data }

              static var __parentType: ApolloAPI.ParentType { GQL.Unions.ConversationItem }
              static var __selections: [ApolloAPI.Selection] { [
                .fragment(ConversationItemFragment.self),
              ] }

              var asMessage: AsMessage? {
                get { _asInlineFragment() }
                set { if let newData = newValue?.__data._data { __data._data = newData }}
              }
              var asConversationActivity: AsConversationActivity? {
                get { _asInlineFragment() }
                set { if let newData = newValue?.__data._data { __data._data = newData }}
              }

              struct Fragments: FragmentContainer {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                var conversationItemFragment: ConversationItemFragment {
                  get { _toFragment() }
                  _modify { var f = conversationItemFragment; yield &f; __data = f.__data }
                  @available(*, unavailable, message: "mutate properties of the fragment instead.")
                  set { preconditionFailure() }
                }
              }

              /// Conversation.Conversation.Items.Datum.AsMessage
              ///
              /// Parent Type: `Message`
              struct AsMessage: GQL.MutableInlineFragment {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: ApolloAPI.ParentType { GQL.Objects.Message }

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

                  var conversationItemFragment: ConversationItemFragment {
                    get { _toFragment() }
                    _modify { var f = conversationItemFragment; yield &f; __data = f.__data }
                    @available(*, unavailable, message: "mutate properties of the fragment instead.")
                    set { preconditionFailure() }
                  }
                  var messageFragment: MessageFragment {
                    get { _toFragment() }
                    _modify { var f = messageFragment; yield &f; __data = f.__data }
                    @available(*, unavailable, message: "mutate properties of the fragment instead.")
                    set { preconditionFailure() }
                  }
                }

                /// Conversation.Conversation.Items.Datum.AsMessage.ReplyTo
                ///
                /// Parent Type: `Message`
                struct ReplyTo: GQL.MutableSelectionSet {
                  var __data: DataDict
                  init(data: DataDict) { __data = data }

                  static var __parentType: ApolloAPI.ParentType { GQL.Objects.Message }

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

              /// Conversation.Conversation.Items.Datum.AsConversationActivity
              ///
              /// Parent Type: `ConversationActivity`
              struct AsConversationActivity: GQL.MutableInlineFragment {
                var __data: DataDict
                init(data: DataDict) { __data = data }

                static var __parentType: ApolloAPI.ParentType { GQL.Objects.ConversationActivity }

                var id: GQL.UUID {
                  get { __data["id"] }
                  set { __data["id"] = newValue }
                }
                var activityTime: GQL.DateTime {
                  get { __data["activityTime"] }
                  set { __data["activityTime"] = newValue }
                }
                var content: Content {
                  get { __data["content"] }
                  set { __data["content"] = newValue }
                }

                struct Fragments: FragmentContainer {
                  var __data: DataDict
                  init(data: DataDict) { __data = data }

                  var conversationItemFragment: ConversationItemFragment {
                    get { _toFragment() }
                    _modify { var f = conversationItemFragment; yield &f; __data = f.__data }
                    @available(*, unavailable, message: "mutate properties of the fragment instead.")
                    set { preconditionFailure() }
                  }
                  var conversationActivityFragment: ConversationActivityFragment {
                    get { _toFragment() }
                    _modify { var f = conversationActivityFragment; yield &f; __data = f.__data }
                    @available(*, unavailable, message: "mutate properties of the fragment instead.")
                    set { preconditionFailure() }
                  }
                }

                /// Conversation.Conversation.Items.Datum.AsConversationActivity.Content
                ///
                /// Parent Type: `ConversationActivityContent`
                struct Content: GQL.MutableSelectionSet {
                  var __data: DataDict
                  init(data: DataDict) { __data = data }

                  static var __parentType: ApolloAPI.ParentType { GQL.Unions.ConversationActivityContent }

                  var asProviderJoinedConversation: AsProviderJoinedConversation? {
                    get { _asInlineFragment() }
                    set { if let newData = newValue?.__data._data { __data._data = newData }}
                  }

                  /// Conversation.Conversation.Items.Datum.AsConversationActivity.Content.AsProviderJoinedConversation
                  ///
                  /// Parent Type: `ProviderJoinedConversation`
                  struct AsProviderJoinedConversation: GQL.MutableInlineFragment {
                    var __data: DataDict
                    init(data: DataDict) { __data = data }

                    static var __parentType: ApolloAPI.ParentType { GQL.Objects.ProviderJoinedConversation }

                    var provider: ConversationActivityFragment.Content.AsProviderJoinedConversation.Provider {
                      get { __data["provider"] }
                      set { __data["provider"] = newValue }
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