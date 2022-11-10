# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed
- The `NablaClient.initialize` method now takes a `Configuration` struct instead of multiple params..
⚠️ This change is breaking and you will need to update all `NablaClient` `initialize` and `init` calls.

- `NablaTheme` colors have been reworked to better support dark mode. The new colors can be found in `NablaTheme.Colors`.
- `NablaTheme` fonts have been reworked for better consistency. The new fonts can be found in `NablaTheme.Fonts`.

To know more about `NablaTheme`, please visit our documentation: https://docs.nabla.com/docs/theming-ios

### Fixed


## [1.0.0-alpha21] - 2022-11-03

### Added

- Added the option to scan a document in conversation screen.
- Added missing NablaTheme properties to customize the video calls action requests in MessagingUI.
- Introduced `ConversationViewControllerDelegate` to control taps on the conversation screen's title view.
- A new `ConversationMessageSender.patient(Patient)` was introduced for conversations with multiple patients.
- New attributes (`messageOtherBackgroundColor`, `textMessageOtherTextColor`, `documentMessageOtherTitleColor`, `audioMessageOtherTitleColor`, `replyToOtherSeparatorColor`) have been added to customize how other patient and system messages appear in the conversation on our Messaging UI module.

### Changed
 
- Updated the cell layout for ended video calls action requests in MessagingUI.
- `ConversationMessageSender.patient` was renamed to `ConversationMessageSender.me`.
- Improved the appearance of the "send message" button.

### Fixed

- Fix an issue that could lead to messages having the wrong size in the conversation screen of the Messaging UI module
- Fix an issue where the spinner when loading more messages in the conversation screen of the Messagging UI module would not be at the correct position
- Remove any color under the avatar picture of a Provider in case the picture has transparency

## [1.0.0-alpha20] - 2022-10-18

### Added

### Changed

- Example app has been renamed to `Messaging Sample App` to better reflect what it showcases.
- The media message input in `NablaMessagingClient.sendMessage` now supports sending `Data` in addition to a file `URL`.
> ⚠️ This change is breaking and you will need to update all `Media` concrete types instantiations by replacing the `fileURL: URL` with `content: MediaContent`.

### Fixed

- Fixed the type of the duration in `keyboardAnimationDurationUserInfoKey` in the `keyboardWillChangeFrameNotification` notification (could cause an issue if other classes are listening and expecting a double value).   

## [1.0.0-alpha19] - 2022-10-07

### Added

- Enabled images and documents sharing in conversation screen.  

### Changed

- The `Conversation` screen's navigation does not use large titles anymore (`navigationItem.largeTitleDisplayMode` defaults to `.never`).
- The `Conversation` screen's `hidesBottomBarWhenPushed` defaults to `true`.

### Fixed

- Fixed the original message preview layout in messaging cells. 
- Fixed the composer text alignment in the conversation screen.


## [1.0.0-alpha18] - 2022-09-21

### Added

- Added `presentScheduleAppointmentViewController` to `NablaScheduling` views.

### Changed

- Messaging Core `VideoCallActionRequest` struct has been renamed to `VideoCallRoomInteractiveMessage`.

### Fixed


## [1.0.0-alpha17] - 2022-09-14

### Added

- Introduced `NablaScheduling` SDK to schedule video call appointments using `NablaVideoCall`.

### Changed

- Updated `LiveKit` pod dependency in `NablaVideoCall` podspec.

### Fixed


## [1.0.0-alpha16] - 2022-09-07

### Added

- It is now possible to change the `title` and `titleView` of `NablaMessagingUI` view controllers.

### Changed

- On simulator: disabled using the camera to send a new photo/video.
- On simulator: disabled joining video calls.
- View controllers no longer enforce `preferLargeTitles` on their `UINavigationController`.
- `NablaVideoCallClient.views.createVideoCallRoomViewController(url:token:)` was removed in favor of `NablaVideoCallClient.openVideoCallRoom(url:token:from:)`. You no longer need to check for the `currentVideoCall` before using this method.

### Fixed

- Prevents a crash on iOS 15.6

## [1.0.0-alpha15] - 2022-08-19

### Added

- Introduced `NablaVideoCall` SDK and video call requests from `NablaMessagingCore`.

### Changed

- Changed `ConversationItems.items` in `NablaMessagingClient.watchItems(ofConversationWithId:)` output ordering to be descending. 
- Removed `NablaUtils` target.   
- A new `modules` parameter is now required when calling `NablaClient.initialize()`:
```swift
NablaClient.initialize(
    apiKey = "Your API Key",
    modules = [
        NablaMessagingModule()
    ]
)
```
- The `NablaViewFactory` has been removed. You can now create the views from `NablaMessagingUI` SDK from `NablaClient.shared.messaging.views` instead.

### Fixed

- Fixed a crash when opening the "add media" action sheet on iPad.


## [1.0.0-alpha14] - 2022-08-08

### Added

### Changed

### Fixed

- Fixed an issue when sending documents from iCloud files.
- Fixed an issue where new conversations would appear twice in the list.

## [1.0.0-alpha13] - 2022-08-05

### Added

### Changed

### Fixed

- Fixed MessagingUI and MessagingCore pods resource_bundles

## [1.0.0-alpha12] - 2022-08-05

### Added

### Changed

### Fixed

- Fixed `NablaMessaginCore` pod resources by adding missing `spec.resource_bundles`.
- Prevents websocket disconnects when keeping the app in foreground but inactive for a long time.

## [1.0.0-alpha11] - 2022-08-04

### Added

- Introduced `NablaMessagingClient.createDraftConversation` to create a conversation locally that does not exist yet server side.
- Adds some `initialMessage` argument to `createConversation` to pre-populate conversations.
- Server-made i18n will now follow user's device language.

### Changed
- `NablaClient.authenticate` now takes a `String` rather than a `UUID` to identify the user. This ID should be uniquely representing your current app user and will be passed to the `SessionTokenProvider` when a call to your backend is needed to get fresh authentication tokens.

### Fixed

- Fixes an issue where creating multiple watchers would cause some to stop receiving updates after one of them is deallocated.
- Fixed a bug preventing conversation from appearing "seen" the first time you tap on them.

## [1.0.0-alpha10] - 2022-07-26

### Added
- You can now tap on links and phone numbers in text messages.

### Changed

### Fixed
- Make some `NablaTheme` property public instead of internal.
- A `NetworkError` will now be returned in case of a network error instead of a `ServerError` before.
- Fix an issue where date separators would be incorrectly ordered in the chat.

## [1.0.0-alpha09] - 2022-07-13

### Added

### Changed
- Conversations in `watchConversations()` are now correctly sorted by their `lastModified` date.
- `Tokens` has been renamed to `AuthTokens` for more clarity.

### Fixed
- Fix for `watchConversations()` that would return the same `Conversation` multiple times under certain conditions.

## [1.0.0-alpha08] - 2022-07-04

### Added

- Methods like `watchConversations()`, `watchConverversation()` or `watchItems(ofConversationWithId:)` now return a `Watcher`.
- Using `NablaMessagingUI` will automatically register some `NotificationRefetchTrigger` for `UIApplication.willEnterForegroundNotification`.

### Changed

- `Configuration` has been renamed to `NetworkConfiguration`. This should not have an impact on an existing app as this is supposed to be for internal tests only.
- Added a new `showComposer` parameter to `NablaViewFactory.createConversationViewController` that can be set to false to hide the message composer for the patient.
- `PaginatedWatcher` now returns proper `NablaError` in case of error instead of the basic `Error`.
- Extract `NablaClient` from `NablaMessagingCore` to a new `NablaCore` library.
- Replaced `providerIdToAssign` by a list a `providerIds` in `NablaMessagingClient.createConversation`.

### Fixed


## [1.0.0-alpha07] - 2022-06-24

### Added
- Added `headerTitleFont`, `headerSubtitleFont`, `headerTitleColor` and `headerSubtitleColor` to `NablaTheme.Conversation` to customize the look of the `ConversationViewController` header

### Changed
- Remove the `description` field from `Conversation` and replace it by a `subtitle` that is displayed by the `ConversationViewController`
- `NablaTheme.Conversation.textSeparatorFont` & `NablaTheme.Conversation.textSeparatorColor` have been split into `dateSeparator` & `conversationActivity` items to allow for customization of the 2 elements differently 

### Fixed

- Add default `title` and `providerIdToAssign` arguments to `createConversation()` endpoint. Fixes [#1](https://github.com/nabla/nabla-ios/issues/1).


## [1.0.0-alpha06] - 2022-06-21

### Added

- Added the handle of replies to message, Core & UI.
- Added video messages, Core & UI.
- `NablaViewFactory` can create an `InboxViewController` that adds the button to create conversation and create them.
- Added optional `title` and `providerIdToAssign` arguments to `NablaMessagingClient.createConversation`.

### Changed

- `ConversationViewController` can be used without a `UINavigationController`
- `NablaMessagingClient.sendMessage` now takes an optional parameter `replyToMessageId ` of type `UUID?` which correspond to the message the patient replies to.
- `MimeType` is now split in different types (image, video, audio, document) and fallback on wildcard when receiving an unknown value.
- `NablaClient.initialise` now logs a `warning` log in case of multiple calls instead of a `failure`.

### Fixed

- `ConversationsListView` and `ConversationViewController` now use the device locale to format dates.


## [1.0.0-alpha05] - 2022-06-13

### Added

- Enable use of `NablaViewFactory.createConversationViewController` with the conversation's `UUID` only.
- It is possible to inject a `Logger` into `NablaClient.initialize` to intercept the SDK's logs.

### Changed

- Used `spec.resource_bundles` instead of `spec.resources` for `NablaMessaginUI` podspec.

### Fixed

- New `ConversationActivity` items are now correctly handled when the chat is open.

## [1.0.0-alpha04] - 2022-06-01

### Added

### Changed

- Automatically refreshes expired `accessToken` returned by `SessionTokenProvider.provideTokens`.


### Fixed


## [1.0.0-alpha03] - 2022-06-01

### Added
 - `ConversationActivity` in conversations. A message is displayed when a provider joins a conversation.
 - `ConversationViewController` now displays system messages, with the right name and avatar.
 - The creation of audio messages is now supported. To make it work, you should fill your `info.plist` with the key `NSMicrophoneUsageDescription` with the desired description.

### Changed
- `ConversationMessageSender.sender` now exposes a `SystemProvider` parameter which contains the name of the organization and the avatar url.
- `ConversationMessageSender.system` now exposes a `SystemProvider` parameter which contains the name of the organization and the avatar url.
- `ConversationMessageSender` now exposes a new `.unknown` case for sender types that are not handled by this version of the SDK.
- `NablaTheme` simplified it's internal naming.

### Fixed

## [1.0-alpha02] - 2022-05-19

### Added
- This CHANGELOG file
- `NablaMessagingUI` conversation screen now separates older messages from newer with a date separator
- `NablaMessagingUI` avatar component now displays Provider initials when no avatar picture is available
- `NablaMessagingUI` conversation screen now has an option to copy any text message in the conversation
- Public APIs are now documented in the code, making it available for developers in Xcode
- Started Cocoapods support for SDK integration

### Changed
- `NablaClient` messaging APIs are now a part of `NablaMessagingClient`. Only initialization and authentication are provided by `NablaClient`
- `NablaAuthenticationProvider` has been renamed `SessionTokenProvider`
- `watchConversationList` has been renamed `watchConversations`
- You can now pass your own instance of `NablaMessagingClient` to any UI component of `NablaMessagingUI`
- `NablaClient.authenticate` now requires a `userId` in addition to the `SessionTokenProvider`, this id should be stable if the authenticated user doesn't change
- Some `NablaMessagingUI` strings have been updated
- `Conversation` struct has been revamped and now contains the providers with a proper `ProviderInConversation` struct
- `NablaMessagingClient.watchConversationItems` now returns a `ConversationItems` struct which only contains the messages themselves. Details of the conversation and its participants should now be watched using `NablaMessagingClient.watchConversation`
- Used explicit errors for `NablaMessagingClient` methods

### Fixed
- `NablaMessagingClient` now correctly triggers `watchConversationItems` watcher when a Provider is not typing anymore
- `NablaMessagingUI` conversation screen now correctly adds an image message in the conversation optimistically while sending it to the server
- `NablaMessagingUI` conversation screen now correctly provides an image picker to upload an image from the library on iOS 13

## [1.0-alpha01] - 2022-05-02

### Added
- First public version of the SDK
