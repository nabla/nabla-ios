// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct DocumentMessageContentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment DocumentMessageContentFragment on DocumentMessageContent {
        __typename
        documentFileUpload {
          __typename
          id
          url {
            __typename
            url
          }
          fileName
          mimeType
          thumbnail {
            __typename
            url {
              __typename
              url
            }
          }
        }
      }
      """

     static let possibleTypes: [String] = ["DocumentMessageContent"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("documentFileUpload", type: .nonNull(.object(DocumentFileUpload.selections))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(documentFileUpload: DocumentFileUpload) {
      self.init(unsafeResultMap: ["__typename": "DocumentMessageContent", "documentFileUpload": documentFileUpload.resultMap])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var documentFileUpload: DocumentFileUpload {
      get {
        return DocumentFileUpload(unsafeResultMap: resultMap["documentFileUpload"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "documentFileUpload")
      }
    }

     struct DocumentFileUpload: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["DocumentFileUpload"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
          GraphQLField("url", type: .nonNull(.object(Url.selections))),
          GraphQLField("fileName", type: .nonNull(.scalar(String.self))),
          GraphQLField("mimeType", type: .nonNull(.scalar(String.self))),
          GraphQLField("thumbnail", type: .object(Thumbnail.selections)),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(id: GQL.UUID, url: Url, fileName: String, mimeType: String, thumbnail: Thumbnail? = nil) {
        self.init(unsafeResultMap: ["__typename": "DocumentFileUpload", "id": id, "url": url.resultMap, "fileName": fileName, "mimeType": mimeType, "thumbnail": thumbnail.flatMap { (value: Thumbnail) -> ResultMap in value.resultMap }])
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

       var thumbnail: Thumbnail? {
        get {
          return (resultMap["thumbnail"] as? ResultMap).flatMap { Thumbnail(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "thumbnail")
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

       struct Thumbnail: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["ImageFileUpload"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .nonNull(.object(Url.selections))),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(url: Url) {
          self.init(unsafeResultMap: ["__typename": "ImageFileUpload", "url": url.resultMap])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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
}
