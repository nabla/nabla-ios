// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  struct ImageMessageContentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment ImageMessageContentFragment on ImageMessageContent {
        __typename
        imageFileUpload {
          __typename
          id
          url {
            __typename
            url
          }
          fileName
          mimeType
          width
          height
        }
      }
      """

    public static let possibleTypes: [String] = ["ImageMessageContent"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("imageFileUpload", type: .nonNull(.object(ImageFileUpload.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(imageFileUpload: ImageFileUpload) {
      self.init(unsafeResultMap: ["__typename": "ImageMessageContent", "imageFileUpload": imageFileUpload.resultMap])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var imageFileUpload: ImageFileUpload {
      get {
        return ImageFileUpload(unsafeResultMap: resultMap["imageFileUpload"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "imageFileUpload")
      }
    }

    public struct ImageFileUpload: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ImageFileUpload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
          GraphQLField("url", type: .nonNull(.object(Url.selections))),
          GraphQLField("fileName", type: .nonNull(.scalar(String.self))),
          GraphQLField("mimeType", type: .nonNull(.scalar(String.self))),
          GraphQLField("width", type: .scalar(Int.self)),
          GraphQLField("height", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GQL.UUID, url: Url, fileName: String, mimeType: String, width: Int? = nil, height: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "ImageFileUpload", "id": id, "url": url.resultMap, "fileName": fileName, "mimeType": mimeType, "width": width, "height": height])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GQL.UUID {
        get {
          return resultMap["id"]! as! GQL.UUID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var url: Url {
        get {
          return Url(unsafeResultMap: resultMap["url"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "url")
        }
      }

      public var fileName: String {
        get {
          return resultMap["fileName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "fileName")
        }
      }

      public var mimeType: String {
        get {
          return resultMap["mimeType"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "mimeType")
        }
      }

      public var width: Int? {
        get {
          return resultMap["width"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "width")
        }
      }

      public var height: Int? {
        get {
          return resultMap["height"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "height")
        }
      }

      public struct Url: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["EphemeralUrl"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String) {
          self.init(unsafeResultMap: ["__typename": "EphemeralUrl", "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var url: String {
          get {
            return resultMap["url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }
      }
    }
  }
}
