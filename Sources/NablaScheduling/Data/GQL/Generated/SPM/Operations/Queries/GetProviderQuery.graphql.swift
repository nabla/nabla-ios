// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  class GetProviderQuery: GraphQLQuery {
    static let operationName: String = "GetProvider"
    static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetProvider($providerId: UUID!) {
          provider(id: $providerId) {
            __typename
            provider {
              __typename
              ...ProviderFragment
            }
          }
        }
        """#,
        fragments: [ProviderFragment.self]
      ))

    var providerId: UUID

    init(providerId: UUID) {
      self.providerId = providerId
    }

    var __variables: Variables? { ["providerId": providerId] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("provider", Provider.self, arguments: ["id": .variable("providerId")]),
      ] }

      var provider: Provider { __data["provider"] }

      /// Provider
      ///
      /// Parent Type: `ProviderOutput`
      struct Provider: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.ProviderOutput }
        static var __selections: [ApolloAPI.Selection] { [
          .field("provider", Provider.self),
        ] }

        var provider: Provider { __data["provider"] }

        /// Provider.Provider
        ///
        /// Parent Type: `Provider`
        struct Provider: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: ApolloAPI.ParentType { GQL.Objects.Provider }
          static var __selections: [ApolloAPI.Selection] { [
            .fragment(ProviderFragment.self),
          ] }

          var id: GQL.UUID { __data["id"] }
          var prefix: String? { __data["prefix"] }
          var firstName: String { __data["firstName"] }
          var lastName: String { __data["lastName"] }
          var title: String? { __data["title"] }
          var avatarUrl: ProviderFragment.AvatarUrl? { __data["avatarUrl"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(data: DataDict) { __data = data }

            var providerFragment: ProviderFragment { _toFragment() }
          }
        }
      }
    }
  }

}