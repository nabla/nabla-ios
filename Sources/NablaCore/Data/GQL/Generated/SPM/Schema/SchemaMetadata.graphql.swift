// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol GQL_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == GQL.SchemaMetadata {}

protocol GQL_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == GQL.SchemaMetadata {}

protocol GQL_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == GQL.SchemaMetadata {}

protocol GQL_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == GQL.SchemaMetadata {}

extension GQL {
  typealias ID = String

  typealias SelectionSet = GQL_SelectionSet

  typealias InlineFragment = GQL_InlineFragment

  typealias MutableSelectionSet = GQL_MutableSelectionSet

  typealias MutableInlineFragment = GQL_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

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