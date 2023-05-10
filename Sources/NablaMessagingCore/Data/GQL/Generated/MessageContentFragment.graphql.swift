// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  struct MessageContentFragment: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
     static let fragmentDefinition: String =
      """
      fragment MessageContentFragment on MessageContent {
        __typename
        ... on TextMessageContent {
          __typename
          ...TextMessageContentFragment
        }
        ... on ImageMessageContent {
          __typename
          ...ImageMessageContentFragment
        }
        ... on VideoMessageContent {
          __typename
          ...VideoMessageContentFragment
        }
        ... on DocumentMessageContent {
          __typename
          ...DocumentMessageContentFragment
        }
        ... on AudioMessageContent {
          __typename
          ...AudioMessageContentFragment
        }
        ... on DeletedMessageContent {
          __typename
          empty: _
        }
        ... on LivekitRoomMessageContent {
          __typename
          ...LivekitRoomMessageContentFragment
        }
      }
      """

     static let possibleTypes: [String] = ["TextMessageContent", "ImageMessageContent", "VideoMessageContent", "DocumentMessageContent", "DeletedMessageContent", "AudioMessageContent", "LivekitRoomMessageContent", "QuestionsSetFormMessageContent"]

     static var selections: [GraphQLSelection] {
      return [
        GraphQLTypeCase(
          variants: ["TextMessageContent": AsTextMessageContent.selections, "ImageMessageContent": AsImageMessageContent.selections, "VideoMessageContent": AsVideoMessageContent.selections, "DocumentMessageContent": AsDocumentMessageContent.selections, "AudioMessageContent": AsAudioMessageContent.selections, "DeletedMessageContent": AsDeletedMessageContent.selections, "LivekitRoomMessageContent": AsLivekitRoomMessageContent.selections],
          default: [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          ]
        )
      ]
    }

     private(set) var resultMap: ResultMap

     init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

     static func makeQuestionsSetFormMessageContent() -> MessageContentFragment {
      return MessageContentFragment(unsafeResultMap: ["__typename": "QuestionsSetFormMessageContent"])
    }

     static func makeTextMessageContent(text: String) -> MessageContentFragment {
      return MessageContentFragment(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
    }

     static func makeDeletedMessageContent(empty: EmptyObject) -> MessageContentFragment {
      return MessageContentFragment(unsafeResultMap: ["__typename": "DeletedMessageContent", "empty": empty])
    }

     var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

     var asTextMessageContent: AsTextMessageContent? {
      get {
        if !AsTextMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsTextMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsTextMessageContent: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["TextMessageContent"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(TextMessageContentFragment.self),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(text: String) {
        self.init(unsafeResultMap: ["__typename": "TextMessageContent", "text": text])
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

         var textMessageContentFragment: TextMessageContentFragment {
          get {
            return TextMessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     var asImageMessageContent: AsImageMessageContent? {
      get {
        if !AsImageMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsImageMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsImageMessageContent: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["ImageMessageContent"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ImageMessageContentFragment.self),
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

         var imageMessageContentFragment: ImageMessageContentFragment {
          get {
            return ImageMessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     var asVideoMessageContent: AsVideoMessageContent? {
      get {
        if !AsVideoMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsVideoMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsVideoMessageContent: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["VideoMessageContent"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(VideoMessageContentFragment.self),
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

         var videoMessageContentFragment: VideoMessageContentFragment {
          get {
            return VideoMessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     var asDocumentMessageContent: AsDocumentMessageContent? {
      get {
        if !AsDocumentMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsDocumentMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsDocumentMessageContent: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["DocumentMessageContent"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(DocumentMessageContentFragment.self),
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

         var documentMessageContentFragment: DocumentMessageContentFragment {
          get {
            return DocumentMessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     var asAudioMessageContent: AsAudioMessageContent? {
      get {
        if !AsAudioMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsAudioMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsAudioMessageContent: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["AudioMessageContent"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(AudioMessageContentFragment.self),
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

         var audioMessageContentFragment: AudioMessageContentFragment {
          get {
            return AudioMessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

     var asDeletedMessageContent: AsDeletedMessageContent? {
      get {
        if !AsDeletedMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsDeletedMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsDeletedMessageContent: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["DeletedMessageContent"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_", alias: "empty", type: .nonNull(.scalar(EmptyObject.self))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(empty: EmptyObject) {
        self.init(unsafeResultMap: ["__typename": "DeletedMessageContent", "empty": empty])
      }

       var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

       var empty: EmptyObject {
        get {
          return resultMap["empty"]! as! EmptyObject
        }
        set {
          resultMap.updateValue(newValue, forKey: "empty")
        }
      }
    }

     var asLivekitRoomMessageContent: AsLivekitRoomMessageContent? {
      get {
        if !AsLivekitRoomMessageContent.possibleTypes.contains(__typename) { return nil }
        return AsLivekitRoomMessageContent(unsafeResultMap: resultMap)
      }
      set {
        guard let newValue = newValue else { return }
        resultMap = newValue.resultMap
      }
    }

     struct AsLivekitRoomMessageContent: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["LivekitRoomMessageContent"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(LivekitRoomMessageContentFragment.self),
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

         var livekitRoomMessageContentFragment: LivekitRoomMessageContentFragment {
          get {
            return LivekitRoomMessageContentFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
