// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension GQL.Unions {
  static let MessageAuthor = Union(
    name: "MessageAuthor",
    possibleTypes: [
      GQL.Objects.System.self,
      GQL.Objects.Patient.self,
      GQL.Objects.Provider.self,
      GQL.Objects.DeletedProvider.self
    ]
  )
}