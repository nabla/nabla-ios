// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GQL {
  struct MessageAuthorFragment: GQL.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment MessageAuthorFragment on MessageAuthor {
        __typename
        ... on Provider {
          ...ProviderFragment
        }
        ... on Patient {
          ...PatientFragment
        }
        ... on System {
          ...SystemMessageFragment
        }
        ... on DeletedProvider {
          empty: _
        }
      }
      """ }

    let __data: DataDict
    init(data: DataDict) { __data = data }

    static var __parentType: ApolloAPI.ParentType { GQL.Unions.MessageAuthor }
    static var __selections: [ApolloAPI.Selection] { [
      .inlineFragment(AsProvider.self),
      .inlineFragment(AsPatient.self),
      .inlineFragment(AsSystem.self),
      .inlineFragment(AsDeletedProvider.self),
    ] }

    var asProvider: AsProvider? { _asInlineFragment() }
    var asPatient: AsPatient? { _asInlineFragment() }
    var asSystem: AsSystem? { _asInlineFragment() }
    var asDeletedProvider: AsDeletedProvider? { _asInlineFragment() }

    /// AsProvider
    ///
    /// Parent Type: `Provider`
    struct AsProvider: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Provider }
      static var __selections: [ApolloAPI.Selection] { [
        .fragment(ProviderFragment.self),
      ] }

      var id: GQL.UUID { __data["id"] }
      var avatarUrl: AvatarUrl? { __data["avatarUrl"] }
      var prefix: String? { __data["prefix"] }
      var firstName: String { __data["firstName"] }
      var lastName: String { __data["lastName"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var providerFragment: ProviderFragment { _toFragment() }
      }

      /// AsProvider.AvatarUrl
      ///
      /// Parent Type: `EphemeralUrl`
      struct AvatarUrl: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: ApolloAPI.ParentType { GQL.Objects.EphemeralUrl }

        var expiresAt: GQL.DateTime { __data["expiresAt"] }
        var url: String { __data["url"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          var ephemeralUrlFragment: EphemeralUrlFragment { _toFragment() }
        }
      }
    }

    /// AsPatient
    ///
    /// Parent Type: `Patient`
    struct AsPatient: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.Patient }
      static var __selections: [ApolloAPI.Selection] { [
        .fragment(PatientFragment.self),
      ] }

      var id: GQL.UUID { __data["id"] }
      var isMe: Bool { __data["isMe"] }
      var displayName: String { __data["displayName"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var patientFragment: PatientFragment { _toFragment() }
      }
    }

    /// AsSystem
    ///
    /// Parent Type: `System`
    struct AsSystem: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.System }
      static var __selections: [ApolloAPI.Selection] { [
        .fragment(SystemMessageFragment.self),
      ] }

      var avatar: SystemMessageFragment.Avatar? { __data["avatar"] }
      var name: String { __data["name"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        var systemMessageFragment: SystemMessageFragment { _toFragment() }
      }
    }

    /// AsDeletedProvider
    ///
    /// Parent Type: `DeletedProvider`
    struct AsDeletedProvider: GQL.InlineFragment {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: ApolloAPI.ParentType { GQL.Objects.DeletedProvider }
      static var __selections: [ApolloAPI.Selection] { [
        .field("_", alias: "empty", GraphQLEnum<GQL.EmptyObject>.self),
      ] }

      var empty: GraphQLEnum<GQL.EmptyObject> { __data["empty"] }
    }
  }

}