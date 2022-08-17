// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct AudioMessageContentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment AudioMessageContentFragment on AudioMessageContent {
        __typename
        audioFileUpload {
          __typename
          id
          url {
            __typename
            ...EphemeralUrlFragment
          }
          fileName
          mimeType
          durationMs
        }
      }
      """

     static let possibleTypes: [String] = ["AudioMessageContent"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("audioFileUpload", type: .nonNull(.object(AudioFileUpload.selections))),
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     init(audioFileUpload: AudioFileUpload) {
      self.init(unsafeResultMap: ["__typename": "AudioMessageContent", "audioFileUpload": audioFileUpload.resultMap])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var audioFileUpload: AudioFileUpload {
      get {
        return AudioFileUpload(unsafeResultMap: resultMap["audioFileUpload"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "audioFileUpload")
      }
    }

     struct AudioFileUpload: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["AudioFileUpload"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GQL.UUID.self))),
          GraphQLField("url", type: .nonNull(.object(Url.selections))),
          GraphQLField("fileName", type: .nonNull(.scalar(String.self))),
          GraphQLField("mimeType", type: .nonNull(.scalar(String.self))),
          GraphQLField("durationMs", type: .scalar(Int.self)),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(id: GQL.UUID, url: Url, fileName: String, mimeType: String, durationMs: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "AudioFileUpload", "id": id, "url": url.resultMap, "fileName": fileName, "mimeType": mimeType, "durationMs": durationMs])
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

       var durationMs: Int? {
        get {
          return resultMap["durationMs"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "durationMs")
        }
      }

       struct Url: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["EphemeralUrl"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(EphemeralUrlFragment.self),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(expiresAt: GQL.DateTime, url: String) {
          self.init(unsafeResultMap: ["__typename": "EphemeralUrl", "expiresAt": expiresAt, "url": url])
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

           var ephemeralUrlFragment: EphemeralUrlFragment {
            get {
              return EphemeralUrlFragment(unsafeResultMap: resultMap)
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
