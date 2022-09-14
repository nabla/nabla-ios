// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class GetProviderQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      query GetProvider($providerId: UUID!) {
        provider(id: $providerId) {
          __typename
          provider {
            __typename
            ...ProviderFragment
          }
        }
      }
      """

     let operationName: String = "GetProvider"

     var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ProviderFragment.fragmentDefinition)
      return document
    }

     var providerId: GQL.UUID

     init(providerId: GQL.UUID) {
      self.providerId = providerId
    }

     var variables: GraphQLMap? {
      return ["providerId": providerId]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Query"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("provider", arguments: ["id": GraphQLVariable("providerId")], type: .nonNull(.object(Provider.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(provider: Provider) {
        self.init(unsafeResultMap: ["__typename": "Query", "provider": provider.resultMap])
      }

       var provider: Provider {
        get {
          return Provider(unsafeResultMap: resultMap["provider"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "provider")
        }
      }

       struct Provider: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["ProviderOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("provider", type: .nonNull(.object(Provider.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(provider: Provider) {
          self.init(unsafeResultMap: ["__typename": "ProviderOutput", "provider": provider.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var provider: Provider {
          get {
            return Provider(unsafeResultMap: resultMap["provider"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "provider")
          }
        }

         struct Provider: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["Provider"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ProviderFragment.self),
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

           var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

           struct Fragments {
             private(set) var resultMap: ResultMap

             init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

             var providerFragment: ProviderFragment {
              get {
                return ProviderFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}
