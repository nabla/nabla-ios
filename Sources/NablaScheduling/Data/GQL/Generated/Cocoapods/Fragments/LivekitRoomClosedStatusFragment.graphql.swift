// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  struct LivekitRoomClosedStatusFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment LivekitRoomClosedStatusFragment on LivekitRoomClosedStatus {
        __typename
        _
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: Apollo.ParentType { GQL.Objects.LivekitRoomClosedStatus }
    static var __selections: [Apollo.Selection] { [
      .field("_", GraphQLEnum<GQL.EmptyObject>.self),
    ] }

    var `_`: GraphQLEnum<GQL.EmptyObject> { __data["_"] }
  }

}