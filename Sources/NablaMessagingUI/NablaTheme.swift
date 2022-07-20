import Foundation
import NablaMessagingCore
import UIKit

/// This struct is used to configure the theme of the app. You can use the default values if needed or
/// override one or many.
///
/// This is divided in two sections:
/// - First are the top level values, those are the primary configurations, used in all of the screens,
/// updating one inpact all of the app
/// - Then you have the sub structs. Those rely on the top level values but offer a fine tune configuration for each element of
/// the SDK.
public enum NablaTheme {
    // MARK: - Colors
    
    public static var primaryColor = CoreAssets.Colors.primary.color
    public static var backgroundColor = CoreAssets.Colors.background.color
    public static var primaryTextColor = CoreAssets.Colors.primaryText.color
    public static var secondaryTextColor = CoreAssets.Colors.secondaryText.color
    public static var alternateTextColor = CoreAssets.Colors.alternateText.color
    public static var lightAlternateTextColor = CoreAssets.Colors.lightAlternateTextColor.color
    public static var darkAlternateTextColor = CoreAssets.Colors.darkAlternateTextColor.color
    public static var secondaryBackgroundColor = CoreAssets.Colors.secondaryBackground.color
    public static var accessoryColor = CoreAssets.Colors.accessory.color
    
    // MARK: - Fonts
    
    public static var largeTitle = UIFont.regular(33)
    public static var title1 = UIFont.regular(27)
    public static var title2 = UIFont.regular(21)
    public static var title3 = UIFont.regular(19)
    public static var headline = UIFont.semiBold(18)
    public static var body = UIFont.regular(16)
    public static var bodyItalic = UIFont.italic(16)
    public static var callout = UIFont.regular(15)
    public static var subhead = UIFont.regular(14)
    public static var footnote = UIFont.regular(12)
    public static var caption1 = UIFont.regular(11)
    public static var caption2 = UIFont.regular(10)
    
    // MARK: - Components

    public enum ConversationPreview {
        /// Background color for the conversations list view. Default set to NablaTheme.backgroundColor
        public static var backgroundColor = NablaTheme.backgroundColor
        /// Background color of a conversation in the conversations list. Default set to NablaTheme.backgroundColor
        public static var previewBackgroundColor = NablaTheme.backgroundColor
        /// Color of the title of a conversation in the conversations list. Default set to NablaTheme.primaryTextColor
        public static var previewTitleColor = NablaTheme.primaryTextColor
        /// Color of the subtitle or message preview of a conversation in the conversations list. Default set to NablaTheme.secondaryTextColor
        public static var previewSubtitleColor = NablaTheme.secondaryTextColor
        /// Color of the time of the last message of a conversation in the conversations list. Default set to NablaTheme.secondaryTextColor
        public static var previewTimeLabelColor = NablaTheme.secondaryTextColor
        /// Color of the dot indicator for an unread message for a conversation in the conversations list. Default set to NablaTheme.primaryColor
        public static var previewUnreadIndicatorColor = NablaTheme.primaryColor

        /// Font used for the title of a conversation in the conversations list. Default set to NablaTheme.body
        public static var previewTitleFont = NablaTheme.body
        /// Font used for the subtitle or message preview of a conversation in the conversations list. Default set to NablaTheme.subhead
        public static var previewSubtitleFont = NablaTheme.subhead
        /// Font used for the time of the last message of a conversation in the conversations list. Default set to NablaTheme.footnote
        public static var previewTimeLabelFont = NablaTheme.footnote

        /// UIImage used for the create conversation button in the Inbox view. Default set to UIImage(systemName: "square.and.pencil")
        public static var createConversationIcon = UIImage(systemName: "square.and.pencil")
        /// Color used for the create conversation button in the Inbox view. Default set to NablaTheme.primary
        public static var createConversationColor = NablaTheme.primaryColor
    }

    public enum Conversation {
        /// Background color for the conversation screen. Default set to NablaTheme.backgroundColor
        public static var backgroundColor = NablaTheme.backgroundColor
        
        /// Font used for the title of a conversation in the conversations list. Default set to NablaTheme.body
        public static var headerTitleFont = NablaTheme.body
        /// Font used for the subtitle or message preview of a conversation in the conversations list. Default set to NablaTheme.subhead
        public static var headerSubtitleFont = NablaTheme.subhead
        /// Color of the title of a conversation in the conversations list. Default set to NablaTheme.primaryTextColor
        public static var headerTitleColor = NablaTheme.primaryTextColor
        /// Color of the subtitle or message preview of a conversation in the conversations list. Default set to NablaTheme.secondaryTextColor
        public static var headerSubtitleColor = NablaTheme.secondaryTextColor

        /// Corner radius used for all messages in the conversation screen. Default set to CGFloat = 10
        public static var messageCornerRadius: CGFloat = 10
        /// Background color used for all patient messages in the conversation screen. Default set to NablaTheme.primaryColor
        public static var messagePatientBackgroundColor = NablaTheme.primaryColor
        /// Background color used for all provider messages in the conversation screen. Default set to NablaTheme.secondaryBackgroundColor
        public static var messageProviderBackgroundColor = NablaTheme.secondaryBackgroundColor
        /// Color used to display the author for all provider messages in the conversation screen. Default set to NablaTheme.secondaryTextColor
        public static var messageAuthorLabelColor = NablaTheme.secondaryTextColor

        /// Font used to display the author for all provider messages in the conversation screen. Default set to NablaTheme.footnote
        public static var messageAuthorLabelFont = NablaTheme.footnote
        /// Font used to display additional info for a message in the conversation screen (like sending status of a message). Default set to NablaTheme.footnote
        public static var messageFooterLabelFont = NablaTheme.footnote

        /// Color used for text messages send by the patient. Default set to NablaTheme.alternateTextColor
        public static var textMessagePatientTextColor = NablaTheme.alternateTextColor
        /// Color used for text messages send by a provider. Default set to NablaTheme.primaryTextColor
        public static var textMessageProviderTextColor = NablaTheme.primaryTextColor
        /// Font used for text messages. Default set to NablaTheme.body
        public static var textMessageFont = NablaTheme.body

        /// Color used for the borders of a deleted message. Default set to NablaTheme.secondaryTextColor
        public static var deletedMessageBorderColor = NablaTheme.secondaryTextColor
        /// Background color of a deleted message. Default set to NablaTheme.backgroundColor
        public static var deletedMessagebackgroundColor = NablaTheme.backgroundColor
        /// Color used to display the "Deleted message" text. Default set to NablaTheme.secondaryTextColor
        public static var deletedMessagetextColor = NablaTheme.secondaryTextColor
        /// Font used to display the "Deleted message" text. Default set to NablaTheme.bodyItalic
        public static var deletedMessagefont = NablaTheme.bodyItalic

        /// UIImage used as the document symbol for a document message in the conversation screen. Default set to UIImage(systemName: "doc")
        public static var documentMessageIcon = UIImage(systemName: "doc")
        /// Font used to display the name of the document for a document message in the conversation screen. Default set to NablaTheme.body
        public static var documentMessageTitleFont = NablaTheme.body
        /// Color used to display the name of the document for a document message sent by the patient in the conversation screen. Default set to NablaTheme.alternateTextColor
        public static var documentMessagePatientTitleColor = NablaTheme.alternateTextColor
        /// Color used to display the name of the document for a document message sent by a provider in the conversation screen. Default set to NablaTheme.primaryTextColor
        public static var documentMessageProviderTitleColor = NablaTheme.primaryTextColor

        /// Color used to display the dots of the typing indicator when a provider is typing a message in the conversation screen. Default set to NablaTheme.primaryColor
        public static var typingIndicatorDotColor = NablaTheme.primaryColor

        /// Font used to display the duration of a voice message in the conversation screen. Default set to NablaTheme.body
        public static var audioMessageDurationLabelFont = NablaTheme.body
        /// Color used to display the duration of a voice message sent by a patient in the conversation screen. Default set to NablaTheme.primaryTextColor
        public static var audioMessagePatientTitleColor = NablaTheme.alternateTextColor
        /// Color used to display the duration of a voice message sent by a provider in the conversation screen. Default set to NablaTheme.primaryTextColor
        public static var audioMessageProviderTitleColor = NablaTheme.primaryTextColor

        /// Color used to display the separator on the left of a replied message, sent by a patient. Default set to NablaTheme.lightAlternateTextColor
        public static var replyToPatientSeparatorColor = NablaTheme.lightAlternateTextColor
        /// Color used to display the preview of the message replied to by a patient. Default set to NablaTheme.lightAlternateTextColor
        public static var replyToPatientPreviewColor = NablaTheme.lightAlternateTextColor
        /// Color used to display the separator on the left of a replied message, sent by a provider. Default set to NablaTheme.darkAlternateTextColor
        public static var replyToProviderSeparatorColor = NablaTheme.darkAlternateTextColor
        /// Color used to display the preview of the message replied to by a provider. Default set to NablaTheme.lightAlternateTextColor
        public static var replyToProviderPreviewColor = NablaTheme.darkAlternateTextColor
        /// Font used to display the author of the message replied to. Default set to subhead.body
        public static var replyToAuthorFont = NablaTheme.subhead
        /// Font used to display the preview of the message replied to. Default set to subhead.body
        public static var replyToPreviewFont = NablaTheme.footnote
        /// UIImage used as the preview of an image replied to. Default set to UIImage(systemName: "photo")
        public static var replyToImageIcon = UIImage(systemName: "photo")
        /// UIImage used as the preview of a video replied to. Default set to UIImage(systemName: "photo")
        public static var replyToVideoIcon = UIImage(systemName: "video.fill")
        /// UIImage used as the preview of a document replied to. Default set to UIImage(systemName: "doc")
        public static var replyToDocumentIcon = UIImage(systemName: "doc")
        /// UIImage used as the preview of an audio message replied to. Default set to UIImage(systemName: "mic")
        public static var replyToAudioIcon = UIImage(systemName: "mic")

        /// Font used to display the text for date separators. Default set to NablaTheme.footnote
        public static var dateSeparatorFont = NablaTheme.footnote
        /// Color used to display the text for date separators. Default set to NablaTheme.secondaryTextColor
        public static var dateSeparatorColor = NablaTheme.secondaryTextColor
        
        /// Font used to display the text of conversation activities. Default set to NablaTheme.footnote
        public static var conversationActivityFont = NablaTheme.footnote
        /// Color used to display the text of conversation activities. Default set to NablaTheme.secondaryTextColor
        public static var conversationActivityColor = NablaTheme.secondaryTextColor

        /// Background color of the message composer in the conversation screen. Default set to NablaTheme.backgroundColor
        public static var composerBackgroundColor = NablaTheme.backgroundColor
        /// Color used to tint buttons in the composer in the conversation screen. Default set to NablaTheme.accessoryColor
        public static var composerButtonTintColor = NablaTheme.accessoryColor
        /// Color used to display the text entered by the user in the composer in the conversation screen. Default set to NablaTheme.primaryTextColor
        public static var composerTextColor = NablaTheme.primaryTextColor
        /// Font used for the text entered by the user in the composer in the conversation screen. Default set to NablaTheme.body
        public static var composerFont = NablaTheme.body
        /// UIImage used for the send button in the composer in the conversation screen. Default set to UIImage(systemName: "paperplane.fill")
        public static var sendIcon = UIImage(systemName: "paperplane.fill")
        /// UIImage used for the send button disabled state in the composer in the conversation screen. Default set to UIImage(systemName: "paperplane")
        public static var sendIconDisabled = UIImage(systemName: "paperplane")
        /// UIImage used for the add media button in the composer in the conversation screen. Default set to UIImage(systemName: "plus")
        public static var addMediaIcon = UIImage(systemName: "plus")
        /// UIImage used for the record audio button in the composer in the conversation screen. Default set to UIImage(systemName: "mic")
        public static var recordAudioIcon = UIImage(systemName: "mic")
        /// UIImage used for the cancel button to delete a recording in progress. Default set to UIImage(systemName: "trash")
        public static var deleteAudioRecordingIcon = UIImage(systemName: "trash")

        /// UIImage used to represent a document to send in the composer in the conversation screen. Default set to UIImage(systemName: "doc.text")
        public static var mediaComposerDocumentIcon = UIImage(systemName: "doc.text")
        /// UIImage used for the delete button for a document to send in the composer in the conversation screen. Default set to UIImage(systemName: "x.circle.fill")
        public static var mediaComposerDeleteButtonIcon = UIImage(systemName: "x.circle.fill")
        /// Color used to tint the document icon for a document to send in the composer in the conversation screen. Default set to NablaTheme.alternateTextColor
        public static var mediaComposerDocumentTintColor = NablaTheme.alternateTextColor
        /// Color of the background of the media composer in the conversation screen. Default set to NablaTheme.secondaryBackgroundColor
        public static var mediaComposerBackgroundColor = NablaTheme.secondaryBackgroundColor
        /// Color used to tint the delete button for a media to send in the composer in the conversation screen. Default set to NablaTheme.primaryTextColor
        public static var mediaCompsoerDeleteButtonTintColor = NablaTheme.primaryTextColor
        /// Background color of the delete button for a media to send in the composer in the conversation screen. Default set to NablaTheme.backgroundColor
        public static var mediaComposerDeleteButtonBackgroundColor = NablaTheme.backgroundColor

        /// Background color used to display the current recording time on the composer. Default set to NablaTheme.primaryColor
        public static var audioComposerBackgroundColor = NablaTheme.primaryColor
        /// Color of the text used to display the current recording time on the composer. Default set to NablaTheme.alternateTextColor
        public static var audioComposerDurationTextColor = NablaTheme.alternateTextColor
        /// Color of the recording indicator on the composer. Default set to UIColor.red
        public static var audioComposerRecordIndicatorColor = UIColor.red

        /// Border color on top of the reply composer. Default set to NablaTheme.lightAlternateTextColor
        public static var composerReplyToBorderColor = NablaTheme.lightAlternateTextColor
        /// Color of the text used to display the author of the message the user replies to. Default set to NablaTheme.primaryTextColor
        public static var composerReplyToAuthorColor = NablaTheme.primaryTextColor
        /// Font of the text used to display the author of the message the user replies to. Default set to UIFont.bold(14)
        public static var composerReplyToAuthorFont = UIFont.bold(14)
        /// Color of the text used to display the preview of the message the user replies to. Default set to NablaTheme.secondaryTextColor
        public static var composerReplyToPreviewColor = NablaTheme.secondaryTextColor
        /// Font of the text used to display the author of the message the user replies to. Default set to NablaTheme.footnote
        public static var composerReplyToPreviewFont = NablaTheme.footnote
        /// UIImage used for the delete button for the reply composer. Default set to UIImage(systemName: "xmark.circle.fill")
        public static var composerReplyToCloseButtonImage = UIImage(systemName: "xmark.circle.fill")
        /// Color of the delete button for the reply composer. Default set to NablaTheme.accessoryColor
        public static var composerReplyToCloseButtonColor = NablaTheme.accessoryColor
    }

    public enum ErrorView {
        /// Font used to display the text explaining the error in the conversations list view or in the conversation list. Default set to NablaTheme.bodyItalic
        public static var labelFont = NablaTheme.bodyItalic
        /// Color of the text explaining the error in the conversations list view or in the conversation list. Default set to NablaTheme.secondaryTextColor
        public static var labelColor = NablaTheme.secondaryTextColor
        /// Font used for the retry button on error in the conversations list view or in the conversation list. Default set to NablaTheme.body
        public static var retryButtonTitleFont = NablaTheme.body
        /// Color of the retry button on error in the conversations list view or in the conversation list. Default set to NablaTheme.primaryColor
        public static var retryButtonTitleColor = NablaTheme.primaryColor
    }

    public enum Shared {
        /// Tint color used for the loading indicator. Default set to NablaTheme.primaryColor
        public static var loadingViewIndicatorTintColor = NablaTheme.primaryColor

        /// Background color used to display the avatar of someone who doesn't have a profile picture. Default set to NablaTheme.primaryColor
        public static var avatarViewBackgroundColor = NablaTheme.primaryColor
    }
    
    public enum ImageDetail {
        /// Color used for the background of the full screen viewer for an image. Default set to NablaTheme.backgroundColor
        public static var backgroundColor = NablaTheme.backgroundColor
    }
}
