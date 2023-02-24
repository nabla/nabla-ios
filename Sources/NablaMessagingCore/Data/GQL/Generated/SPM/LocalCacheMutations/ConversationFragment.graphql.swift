// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct ConversationFragment: GQL.MutableSelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ConversationFragment on Conversation {
        __typename
        id
        title
        subtitle
        lastMessagePreview
        unreadMessageCount
        inboxPreviewTitle
        updatedAt
        pictureUrl {
          __typename
          ...EphemeralUrlFragment
        }
        providers {
          __typename
          ...ProviderInConversationFragment
        }
        isLocked
      }
      """ }

    var __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.Conversation }
    static var __selections: [ApolloAPI.Selection] { [
      .field("id", GQL.UUID.self),
      .field("title", String?.self),
      .field("subtitle", String?.self),
      .field("lastMessagePreview", String?.self),
      .field("unreadMessageCount", Int.self),
      .field("inboxPreviewTitle", String.self),
      .field("updatedAt", GQL.DateTime.self),
      .field("pictureUrl", PictureUrl?.self),
      .field("providers", [Provider].self),
      .field("isLocked", Bool.self),
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

    /// PictureUrl
    ///
    /// Parent Type: `EphemeralUrl`
    struct PictureUrl: GQL.MutableSelectionSet {
      var __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.EphemeralUrl }
      static var __selections: [ApolloAPI.Selection] { [
        .fragment(EphemeralUrlFragment.self),
      ] }

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

    /// Provider
    ///
    /// Parent Type: `ProviderInConversation`
    struct Provider: GQL.MutableSelectionSet {
      var __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.ProviderInConversation }
      static var __selections: [ApolloAPI.Selection] { [
        .fragment(ProviderInConversationFragment.self),
      ] }

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

      /// Provider.Provider
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

        /// Provider.Provider.AvatarUrl
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