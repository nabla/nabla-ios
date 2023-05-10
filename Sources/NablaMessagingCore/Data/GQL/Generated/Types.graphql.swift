// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 enum GQL {
   struct SendMessageInput: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - content
    ///   - clientId
    ///   - replyToMessageId
     init(content: SendMessageContentInput, clientId: GQL.UUID, replyToMessageId: Swift.Optional<GQL.UUID?> = nil) {
      graphQLMap = ["content": content, "clientId": clientId, "replyToMessageId": replyToMessageId]
    }

     var content: SendMessageContentInput {
      get {
        return graphQLMap["content"] as! SendMessageContentInput
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "content")
      }
    }

     var clientId: GQL.UUID {
      get {
        return graphQLMap["clientId"] as! GQL.UUID
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "clientId")
      }
    }

     var replyToMessageId: Swift.Optional<GQL.UUID?> {
      get {
        return graphQLMap["replyToMessageId"] as? Swift.Optional<GQL.UUID?> ?? Swift.Optional<GQL.UUID?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "replyToMessageId")
      }
    }
  }

   struct SendMessageContentInput: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - textInput
    ///   - imageInput
    ///   - videoInput
    ///   - documentInput
    ///   - audioInput
     init(textInput: Swift.Optional<SendTextMessageInput?> = nil, imageInput: Swift.Optional<SendImageMessageInput?> = nil, videoInput: Swift.Optional<SendVideoMessageInput?> = nil, documentInput: Swift.Optional<SendDocumentMessageInput?> = nil, audioInput: Swift.Optional<SendAudioMessageInput?> = nil) {
      graphQLMap = ["textInput": textInput, "imageInput": imageInput, "videoInput": videoInput, "documentInput": documentInput, "audioInput": audioInput]
    }

     var textInput: Swift.Optional<SendTextMessageInput?> {
      get {
        return graphQLMap["textInput"] as? Swift.Optional<SendTextMessageInput?> ?? Swift.Optional<SendTextMessageInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "textInput")
      }
    }

     var imageInput: Swift.Optional<SendImageMessageInput?> {
      get {
        return graphQLMap["imageInput"] as? Swift.Optional<SendImageMessageInput?> ?? Swift.Optional<SendImageMessageInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "imageInput")
      }
    }

     var videoInput: Swift.Optional<SendVideoMessageInput?> {
      get {
        return graphQLMap["videoInput"] as? Swift.Optional<SendVideoMessageInput?> ?? Swift.Optional<SendVideoMessageInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "videoInput")
      }
    }

     var documentInput: Swift.Optional<SendDocumentMessageInput?> {
      get {
        return graphQLMap["documentInput"] as? Swift.Optional<SendDocumentMessageInput?> ?? Swift.Optional<SendDocumentMessageInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "documentInput")
      }
    }

     var audioInput: Swift.Optional<SendAudioMessageInput?> {
      get {
        return graphQLMap["audioInput"] as? Swift.Optional<SendAudioMessageInput?> ?? Swift.Optional<SendAudioMessageInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "audioInput")
      }
    }
  }

   struct SendTextMessageInput: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - text
     init(text: String) {
      graphQLMap = ["text": text]
    }

     var text: String {
      get {
        return graphQLMap["text"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "text")
      }
    }
  }

   struct SendImageMessageInput: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - upload
     init(upload: UploadInput) {
      graphQLMap = ["upload": upload]
    }

     var upload: UploadInput {
      get {
        return graphQLMap["upload"] as! UploadInput
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "upload")
      }
    }
  }

   struct UploadInput: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - uuid
     init(uuid: GQL.UUID) {
      graphQLMap = ["uuid": uuid]
    }

     var uuid: GQL.UUID {
      get {
        return graphQLMap["uuid"] as! GQL.UUID
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "uuid")
      }
    }
  }

   struct SendVideoMessageInput: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - upload
     init(upload: UploadInput) {
      graphQLMap = ["upload": upload]
    }

     var upload: UploadInput {
      get {
        return graphQLMap["upload"] as! UploadInput
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "upload")
      }
    }
  }

   struct SendDocumentMessageInput: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - upload
     init(upload: UploadInput) {
      graphQLMap = ["upload": upload]
    }

     var upload: UploadInput {
      get {
        return graphQLMap["upload"] as! UploadInput
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "upload")
      }
    }
  }

   struct SendAudioMessageInput: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - upload
     init(upload: UploadInput) {
      graphQLMap = ["upload": upload]
    }

     var upload: UploadInput {
      get {
        return graphQLMap["upload"] as! UploadInput
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "upload")
      }
    }
  }

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
