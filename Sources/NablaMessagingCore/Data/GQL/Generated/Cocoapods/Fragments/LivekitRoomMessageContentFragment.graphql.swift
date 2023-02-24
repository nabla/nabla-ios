// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct LivekitRoomMessageContentFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment LivekitRoomMessageContentFragment on LivekitRoomMessageContent {
        __typename
        livekitRoom {
          __typename
          ...LivekitRoomFragment
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoomMessageContent }
    static var __selections: [Apollo.Selection] { [
      .field("livekitRoom", LivekitRoom.self),
    ] }

    var livekitRoom: LivekitRoom { __data["livekitRoom"] }

    /// LivekitRoom
    ///
    /// Parent Type: `LivekitRoom`
    struct LivekitRoom: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoom }
      static var __selections: [Apollo.Selection] { [
        .fragment(LivekitRoomFragment.self),
      ] }

      var uuid: GQL.UUID { __data["uuid"] }
      var status: Status { __data["status"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var livekitRoomFragment: LivekitRoomFragment { _toFragment() }
      }

      /// LivekitRoom.Status
      ///
      /// Parent Type: `LivekitRoomStatus`
      struct Status: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Unions.LivekitRoomStatus }

        var asLivekitRoomOpenStatus: AsLivekitRoomOpenStatus? { _asInlineFragment() }
        var asLivekitRoomClosedStatus: AsLivekitRoomClosedStatus? { _asInlineFragment() }

        /// LivekitRoom.Status.AsLivekitRoomOpenStatus
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

        /// LivekitRoom.Status.AsLivekitRoomClosedStatus
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