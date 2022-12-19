import Foundation
import NablaCore
import UIKit

public extension NablaTheme {
    enum ConversationPreview {
        /// Background color for the conversations list view.
        public static var backgroundColor = Colors.Background.base
        /// Background color of a conversation in the conversations list.
        public static var previewBackgroundColor = Colors.Background.base
        /// Color of the title of a conversation in the conversations list.
        public static var previewTitleColor = Colors.Text.base
        /// Color of the subtitle or message preview of a conversation in the conversations list.
        public static var previewSubtitleColor = Colors.Text.subdued
        /// Color of the time of the last message of a conversation in the conversations list.
        public static var previewTimeLabelColor = Colors.Text.subdued
        /// Color of the dot indicator for an unread message for a conversation in the conversations list.
        public static var previewUnreadIndicatorColor = Colors.Text.accent

        /// Font used for the title of a conversation in the conversations list.
        public static var previewTitleFont = Fonts.subtitleMedium
        /// Font used for the title of an unread conversation in the conversations list.
        public static var previewUnreadTitleFont = Fonts.subtitleBold
        /// Font used for the subtitle or message preview of a conversation in the conversations list.
        public static var previewSubtitleFont = Fonts.body
        /// Font used for the subtitle or message preview of a conversation in the conversations list.
        public static var previewUnreadSubtitleFont = Fonts.bodyMedium
        /// Font used for the time of the last message of a conversation in the conversations list.
        public static var previewTimeLabelFont = Fonts.smallText

        /// UIImage used for the create conversation button in the Inbox view.
        public static var createConversationIcon = UIImage(systemName: "square.and.pencil")
        /// Color used for the create conversation button in the Inbox view.
        public static var createConversationColor = Colors.Text.accent
        
        public enum EmptyView {
            /// Color of the message when the conversation list is empty.
            public static var textColor = Colors.Text.subdued
            /// Font of the message when the conversation list is empty.
            public static var font = Fonts.subtitleMedium
        }
    }

    enum Conversation {
        /// Background color for the conversation screen.
        public static var backgroundColor = Colors.Background.base
        
        /// Font used for the title of a conversation in the conversations list.
        public static var headerTitleFont = Fonts.subtitleBold
        /// Font used for the subtitle or message preview of a conversation in the conversations list.
        public static var headerSubtitleFont = Fonts.smallText
        /// Color of the title of a conversation in the conversations list.
        public static var headerTitleColor = Colors.Text.base
        /// Color of the subtitle or message preview of a conversation in the conversations list.
        public static var headerSubtitleColor = Colors.Text.subdued

        /// Corner radius used for all messages in the conversation screen.
        public static var messageCornerRadius: CGFloat = 10
        /// Background color used for all patient messages in the conversation screen.
        public static var messagePatientBackgroundColor = Colors.Fill.accent
        /// Background color used for all provider messages in the conversation screen.
        public static var messageProviderBackgroundColor = Colors.Fill.base
        /// Background color used for all other user messages in the conversation screen (may be system or another user).
        public static var messageOtherBackgroundColor = Colors.Fill.base
        
        /// Color used to display the author for all provider messages in the conversation screen.
        public static var messageAuthorLabelColor = Colors.Text.subdued
        /// Font used to display the author for all provider messages in the conversation screen.
        public static var messageAuthorLabelFont = Fonts.smallText
        /// Font used to display additional info for a message in the conversation screen (like sending status of a message).
        public static var messageFooterLabelFont = Fonts.smallText

        /// Color used for text messages send by the patient.
        public static var textMessagePatientTextColor = Colors.Text.onAccent
        /// Color used for text messages send by a provider.
        public static var textMessageProviderTextColor = Colors.Text.base
        /// Color used for text messages send by another user (may be system or another patient).
        public static var textMessageOtherTextColor = Colors.Text.base
        /// Font used for text messages.
        public static var textMessageFont = Fonts.caption

        /// Color used for the borders of a deleted message.
        public static var deletedMessageBorderColor = Colors.Stroke.base
        /// Background color of a deleted message.
        public static var deletedMessageBackgroundColor = Colors.Background.base
        /// Color used to display the "Deleted message" text.
        public static var deletedMessageTextColor = Colors.Text.subdued
        /// Font used to display the "Deleted message" text.
        public static var deletedMessageFont = Fonts.bodyItalic

        /// UIImage used as the document symbol for a document message in the conversation screen.
        public static var documentMessageIcon = UIImage(systemName: "doc")
        /// Font used to display the name of the document for a document message in the conversation screen.
        public static var documentMessageTitleFont = Fonts.body
        /// Color used to display the name of the document for a document message sent by the patient in the conversation screen.
        public static var documentMessagePatientTitleColor = Colors.Text.onAccent
        /// Color used to display the name of the document for a document message sent by a provider in the conversation screen.
        public static var documentMessageProviderTitleColor = Colors.Text.base
        /// Color used to display the name of the document for a document message sent by another user in the conversation screen (may be system or another patient).
        public static var documentMessageOtherTitleColor = Colors.Text.base

        /// Color used to display the dots of the typing indicator when a provider is typing a message in the conversation screen.
        public static var typingIndicatorDotColor = Colors.Text.subdued

        /// Font used to display the duration of a voice message in the conversation screen.
        public static var audioMessageDurationLabelFont = Fonts.body
        /// Color used to display the duration of a voice message sent by a patient in the conversation screen.
        public static var audioMessagePatientTitleColor = Colors.Text.onAccent
        /// Color used to display the duration of a voice message sent by a provider in the conversation screen.
        public static var audioMessageProviderTitleColor = Colors.Text.base
        /// Color used to display the duration of a voice message sent by another user  in the conversation screen (might be system or another patient).
        public static var audioMessageOtherTitleColor = Colors.Text.base

        /// Icon for the video call action requests in the conversation screen.
        public static var videoCallActionRequestIcon: UIImage = CoreAssets.Assets.videoCallActionRequestIcon.image
        /// Theme for the video call action requests button in the conversation screen.
        public static var videoCallActionRequestButton = Button.base

        /// Color used to display the separator on the left of a replied message, sent by a patient.
        public static var replyToPatientSeparatorColor = Colors.Stroke.onAccent
        /// Color used to display the preview of the message replied to by a patient.
        public static var replyToPatientPreviewColor = Colors.Text.onAccentSubdued
        /// Color used to display the separator on the left of a replied message, sent by a provider.
        public static var replyToProviderSeparatorColor = Colors.Stroke.base
        /// Color used to display the preview of the message replied to by a provider.
        public static var replyToProviderPreviewColor = Colors.Text.subdued
        /// Color used to display the preview of the message replied to by another user (may be system or another patient).
        public static var replyToOtherSeparatorColor = Colors.Text.subdued
        /// Font used to display the author of the message replied to.
        public static var replyToAuthorFont = Fonts.body
        /// Font used to display the preview of the message replied to.
        public static var replyToPreviewFont = Fonts.smallText
        /// UIImage used as the preview of an image replied to.
        public static var replyToImageIcon = UIImage(systemName: "photo")
        /// UIImage used as the preview of a video replied to.
        public static var replyToVideoIcon = UIImage(systemName: "video.fill")
        /// UIImage used as the preview of a document replied to.
        public static var replyToDocumentIcon = UIImage(systemName: "doc")
        /// UIImage used as the preview of an audio message replied to.
        public static var replyToAudioIcon = UIImage(systemName: "mic")

        /// Font used to display the text for date separators.
        public static var dateSeparatorFont = Fonts.smallText
        /// Color used to display the text for date separators.
        public static var dateSeparatorColor = Colors.Text.subdued
        
        /// Font used to display the text of conversation activities.
        public static var conversationActivityFont = Fonts.smallText
        /// Color used to display the text of conversation activities.
        public static var conversationActivityColor = Colors.Text.subdued

        /// Background color of the message composer in the conversation screen.
        public static var composerBackgroundColor = Colors.Background.base
        /// Color used to tint buttons in the composer in the conversation screen.
        public static var composerButtonTintColor = Colors.Stroke.subdued
        /// Color used to tint buttons in the composer in the conversation screen.
        public static var composerButtonHighlightedTintColor = Colors.Stroke.accent
        /// Color used for the border of the composer in the conversation screen.
        public static var composerBorderColor = Colors.Stroke.subdued
        /// Color used to display the text entered by the user in the composer in the conversation screen.
        public static var composerTextColor = Colors.Text.base
        /// Font used for the text entered by the user in the composer in the conversation screen.
        public static var composerFont = Fonts.body
        /// UIImage used for the send button in the composer in the conversation screen.
        public static var sendIcon = UIImage(systemName: "arrow.up.circle.fill")
        /// UIImage used for the send button disabled state in the composer in the conversation screen.
        public static var sendIconDisabled = UIImage(systemName: "arrow.up.circle.fill")
        /// UIImage used for the add media button in the composer in the conversation screen.
        public static var addMediaIcon = UIImage(systemName: "plus")
        /// UIImage used for the record audio button in the composer in the conversation screen.
        public static var recordAudioIcon = UIImage(systemName: "mic")
        /// UIImage used for the cancel button to delete a recording in progress.
        public static var deleteAudioRecordingIcon = UIImage(systemName: "trash")

        /// UIImage used to represent a document to send in the composer in the conversation screen.
        public static var mediaComposerDocumentIcon = UIImage(systemName: "doc.text")
        /// UIImage used for the delete button for a document to send in the composer in the conversation screen.
        public static var mediaComposerDeleteButtonIcon = UIImage(systemName: "x.circle.fill")
        /// Color used to tint the document icon for a document to send in the composer in the conversation screen.
        public static var mediaComposerDocumentTintColor = Colors.Text.subdued
        /// Color of the background of the media composer in the conversation screen.
        public static var mediaComposerBackgroundColor = Colors.Fill.card
        /// Color used to tint the delete button for a media to send in the composer in the conversation screen.
        public static var mediaComposerDeleteButtonTintColor = Colors.Stroke.base
        /// Background color of the delete button for a media to send in the composer in the conversation screen.
        public static var mediaComposerDeleteButtonBackgroundColor = Colors.Stroke.onAccent

        /// Background color used to display the current recording time on the composer.
        public static var audioComposerBackgroundColor = Colors.Fill.accent
        /// Color of the text used to display the current recording time on the composer.
        public static var audioComposerDurationTextColor = Colors.Text.onAccent
        /// Color of the recording indicator on the composer.
        public static var audioComposerRecordIndicatorColor = Colors.Fill.danger

        /// Border color on top of the reply composer.
        public static var composerReplyToBorderColor = Colors.Stroke.subdued
        /// Color of the text used to display the author of the message the user replies to.
        public static var composerReplyToAuthorColor = Colors.Text.base
        /// Font of the text used to display the author of the message the user replies to.
        public static var composerReplyToAuthorFont = Fonts.body
        /// Color of the text used to display the preview of the message the user replies to.
        public static var composerReplyToPreviewColor = Colors.Text.subdued
        /// Font of the text used to display the author of the message the user replies to.
        public static var composerReplyToPreviewFont = Fonts.smallText
        /// UIImage used for the delete button for the reply composer.
        public static var composerReplyToCloseButtonImage = UIImage(systemName: "xmark.circle.fill")
        /// Color of the delete button for the reply composer.
        public static var composerReplyToCloseButtonColor = Colors.Fill.subdued
    }

    enum ErrorView {
        /// Font used to display the text explaining the error in the conversations list view or in the conversation list.
        public static var labelFont = Fonts.bodyItalic
        /// Color of the text explaining the error in the conversations list view or in the conversation list.
        public static var labelColor = Colors.Text.base
        /// Font used for the retry button on error in the conversations list view or in the conversation list.
        public static var retryButtonTitleFont = Fonts.body
        /// Color of the retry button on error in the conversations list view or in the conversation list.
        public static var retryButtonTitleColor = Colors.Text.accent
    }
    
    enum ImageDetail {
        /// Color used for the background of the full screen viewer for an image.
        public static var backgroundColor = Colors.Background.base
        /// UIIColor used to tint the buttons in the full screen viewer for an image.
        public static var iconsTintColor = Colors.Stroke.accent
    }
    
    enum DocumentDetail {
        /// UIIColor used to tint the buttons in the full screen viewer for a document.
        public static var iconsTintColor = Colors.Stroke.accent
    }
}
