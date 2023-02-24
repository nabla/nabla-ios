// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct SystemMessageFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment SystemMessageFragment on System {
        __typename
        avatar {
          __typename
          url {
            __typename
            ...EphemeralUrlFragment
          }
        }
        name
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.System }
    static var __selections: [Apollo.Selection] { [
      .field("avatar", Avatar?.self),
      .field("name", String.self),
    ] }

    var avatar: Avatar? { __data["avatar"] }
    var name: String { __data["name"] }

    /// Avatar
    ///
    /// Parent Type: `ImageFileUpload`
    struct Avatar: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.ImageFileUpload }
      static var __selections: [Apollo.Selection] { [
        .field("url", Url.self),
      ] }

      var url: Url { __data["url"] }

      /// Avatar.Url
      ///
      /// Parent Type: `EphemeralUrl`
      struct Url: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.EphemeralUrl }
        static var __selections: [Apollo.Selection] { [
          .fragment(EphemeralUrlFragment.self),
        ] }

        var expiresAt: GQL.DateTime { __data["expiresAt"] }
        var url: String { __data["url"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var ephemeralUrlFragment: EphemeralUrlFragment { _toFragment() }
        }
      }
    }
  }

}