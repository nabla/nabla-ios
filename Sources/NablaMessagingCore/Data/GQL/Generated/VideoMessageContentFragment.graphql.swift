// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct VideoMessageContentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment VideoMessageContentFragment on VideoMessageContent {
        __typename
        videoFileUpload {
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

     static let possibleTypes: [String] = ["VideoMessageContent"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("videoFileUpload", type: .nonNull(.object(VideoFileUpload.selections))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(videoFileUpload: VideoFileUpload) {
      self.init(unsafeResultMap: ["__typename": "VideoMessageContent", "videoFileUpload": videoFileUpload.resultMap])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var videoFileUpload: VideoFileUpload {
      get {
        return VideoFileUpload(unsafeResultMap: resultMap["videoFileUpload"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "videoFileUpload")
      }
    }

     struct VideoFileUpload: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["VideoFileUpload"]

       static var selections: [GraphQLSelection] {
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

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(id: GQL.UUID, url: Url, fileName: String, mimeType: String, width: Int? = nil, height: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "VideoFileUpload", "id": id, "url": url.resultMap, "fileName": fileName, "mimeType": mimeType, "width": width, "height": height])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var id: GQL.UUID {
        get {
          return resultMap["id"]! as! GQL.UUID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

       var url: Url {
        get {
          return Url(unsafeResultMap: resultMap["url"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "url")
        }
      }

       var fileName: String {
        get {
          return resultMap["fileName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "fileName")
        }
      }

       var mimeType: String {
        get {
          return resultMap["mimeType"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "mimeType")
        }
      }

       var width: Int? {
        get {
          return resultMap["width"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "width")
        }
      }

       var height: Int? {
        get {
          return resultMap["height"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "height")
        }
      }

       struct Url: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["EphemeralUrl"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(url: String) {
          self.init(unsafeResultMap: ["__typename": "EphemeralUrl", "url": url])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var url: String {
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
