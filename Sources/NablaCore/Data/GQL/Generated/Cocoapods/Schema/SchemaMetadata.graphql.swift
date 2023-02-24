// @generated
// This file was automatically generated and should not be edited.

import Apollo

protocol GQL_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == GQL.SchemaMetadata {}

protocol GQL_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == GQL.SchemaMetadata {}

protocol GQL_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == GQL.SchemaMetadata {}

protocol GQL_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == GQL.SchemaMetadata {}

extension GQL {
  typealias ID = String

  typealias SelectionSet = GQL_SelectionSet

  typealias InlineFragment = GQL_InlineFragment

  typealias MutableSelectionSet = GQL_MutableSelectionSet

  typealias MutableInlineFragment = GQL_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Mutation": return GQL.Objects.Mutation
      case "UpdateDeviceOutput": return GQL.Objects.UpdateDeviceOutput
      case "Sentry": return GQL.Objects.Sentry
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}