// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct LivekitRoomFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment LivekitRoomFragment on LivekitRoom {
        __typename
        uuid
        status {
          __typename
          ... on LivekitRoomOpenStatus {
            ...LivekitRoomOpenStatusFragment
          }
          ... on LivekitRoomClosedStatus {
            ...LivekitRoomClosedStatusFragment
          }
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Objects.LivekitRoom }
    static var __selections: [ApolloAPI.Selection] { [
      .field("uuid", GQL.UUID.self),
      .field("status", Status.self),
    ] }

    var uuid: GQL.UUID { __data["uuid"] }
    var status: Status { __data["status"] }

    /// Status
    ///
    /// Parent Type: `LivekitRoomStatus`
    struct Status: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Unions.LivekitRoomStatus }
      static var __selections: [ApolloAPI.Selection] { [
        .inlineFragment(AsLivekitRoomOpenStatus.self),
        .inlineFragment(AsLivekitRoomClosedStatus.self),
      ] }

      var asLivekitRoomOpenStatus: AsLivekitRoomOpenStatus? { _asInlineFragment() }
      var asLivekitRoomClosedStatus: AsLivekitRoomClosedStatus? { _asInlineFragment() }

      /// Status.AsLivekitRoomOpenStatus
      ///
      /// Parent Type: `LivekitRoomOpenStatus`
      struct AsLivekitRoomOpenStatus: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.LivekitRoomOpenStatus }
        static var __selections: [ApolloAPI.Selection] { [
          .fragment(LivekitRoomOpenStatusFragment.self),
        ] }

        var url: String { __data["url"] }
        var token: String { __data["token"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var livekitRoomOpenStatusFragment: LivekitRoomOpenStatusFragment { _toFragment() }
        }
      }

      /// Status.AsLivekitRoomClosedStatus
      ///
      /// Parent Type: `LivekitRoomClosedStatus`
      struct AsLivekitRoomClosedStatus: GQL.InlineFragment {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.LivekitRoomClosedStatus }
        static var __selections: [ApolloAPI.Selection] { [
          .fragment(LivekitRoomClosedStatusFragment.self),
        ] }

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