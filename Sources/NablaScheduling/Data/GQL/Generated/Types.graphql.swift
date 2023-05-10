// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 enum GQL {
   struct OpaqueCursorPage: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - cursor
    ///   - numberOfItems
     init(cursor: Swift.Optional<String?> = nil, numberOfItems: Swift.Optional<Int?> = nil) {
      graphQLMap = ["cursor": cursor, "numberOfItems": numberOfItems]
    }

     var cursor: Swift.Optional<String?> {
      get {
        return graphQLMap["cursor"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "cursor")
      }
    }

     var numberOfItems: Swift.Optional<Int?> {
      get {
        return graphQLMap["numberOfItems"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "numberOfItems")
      }
    }
  }

   enum EmptyObject: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
     typealias RawValue = String
    case empty
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

     init?(rawValue: RawValue) {
      switch rawValue {
        case "EMPTY": self = .empty
        default: self = .__unknown(rawValue)
      }
    }

     var rawValue: RawValue {
      switch self {
        case .empty: return "EMPTY"
        case .__unknown(let value): return value
      }
    }

     static func == (lhs: EmptyObject, rhs: EmptyObject) -> Bool {
      switch (lhs, rhs) {
        case (.empty, .empty): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

     static var allCases: [EmptyObject] {
      return [
        .empty,
      ]
    }
  }
}
