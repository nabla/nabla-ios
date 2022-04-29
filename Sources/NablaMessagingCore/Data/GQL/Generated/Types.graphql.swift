// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public enum GQL {
  public struct SendMessageContentInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - textInput
    ///   - imageInput
    ///   - documentInput
    public init(textInput: Swift.Optional<SendTextMessageInput?> = nil, imageInput: Swift.Optional<SendImageMessageInput?> = nil, documentInput: Swift.Optional<SendDocumentMessageInput?> = nil) {
      graphQLMap = ["textInput": textInput, "imageInput": imageInput, "documentInput": documentInput]
    }

    public var textInput: Swift.Optional<SendTextMessageInput?> {
      get {
        return graphQLMap["textInput"] as? Swift.Optional<SendTextMessageInput?> ?? Swift.Optional<SendTextMessageInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "textInput")
      }
    }

    public var imageInput: Swift.Optional<SendImageMessageInput?> {
      get {
        return graphQLMap["imageInput"] as? Swift.Optional<SendImageMessageInput?> ?? Swift.Optional<SendImageMessageInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "imageInput")
      }
    }

    public var documentInput: Swift.Optional<SendDocumentMessageInput?> {
      get {
        return graphQLMap["documentInput"] as? Swift.Optional<SendDocumentMessageInput?> ?? Swift.Optional<SendDocumentMessageInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "documentInput")
      }
    }
  }

  public struct SendTextMessageInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - text
    public init(text: String) {
      graphQLMap = ["text": text]
    }

    public var text: String {
      get {
        return graphQLMap["text"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "text")
      }
    }
  }

  public struct SendImageMessageInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - upload
    public init(upload: UploadInput) {
      graphQLMap = ["upload": upload]
    }

    public var upload: UploadInput {
      get {
        return graphQLMap["upload"] as! UploadInput
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "upload")
      }
    }
  }

  public struct UploadInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - uuid
    public init(uuid: GQL.UUID) {
      graphQLMap = ["uuid": uuid]
    }

    public var uuid: GQL.UUID {
      get {
        return graphQLMap["uuid"] as! GQL.UUID
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "uuid")
      }
    }
  }

  public struct SendDocumentMessageInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - upload
    public init(upload: UploadInput) {
      graphQLMap = ["upload": upload]
    }

    public var upload: UploadInput {
      get {
        return graphQLMap["upload"] as! UploadInput
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "upload")
      }
    }
  }

  public struct OpaqueCursorPage: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - cursor
    ///   - numberOfItems
    public init(cursor: Swift.Optional<String?> = nil, numberOfItems: Swift.Optional<Int?> = nil) {
      graphQLMap = ["cursor": cursor, "numberOfItems": numberOfItems]
    }

    public var cursor: Swift.Optional<String?> {
      get {
        return graphQLMap["cursor"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "cursor")
      }
    }

    public var numberOfItems: Swift.Optional<Int?> {
      get {
        return graphQLMap["numberOfItems"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "numberOfItems")
      }
    }
  }

  public enum EmptyObject: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case empty
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "EMPTY": self = .empty
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .empty: return "EMPTY"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: EmptyObject, rhs: EmptyObject) -> Bool {
      switch (lhs, rhs) {
        case (.empty, .empty): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [EmptyObject] {
      return [
        .empty,
      ]
    }
  }
}
