# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Fixed

- Core: Improve live updates stability. Under bad network conditions, some websocket subscription would not reconnect as expected.
- Core: Fixed watchers emitting new values when the observed object don't change.

## [1.1.2] - 2023-05-10

### Added

### Changed

### Fixed

- Core: Reverted Apollo library to version `0.51.2`. Fixes cache issue preventing the loading of older conversation messages.


## [1.1.1] - 2023-04-24

### Added

### Changed

### Fixed

- Messaging core: Fix a race condition where auto replies would break  websocket connection and prevent new events to be handled live.

## [1.1.0] - 2023-04-18

### Added

- Global: Added portuguese localization.
- Messaging core: Added new `lastMessage` property on `Conversation` that gives access to the whole message and not just its preview.

### Changed

### Fixed


## [1.0.0] - 2023-03-16

### Added

### Changed

- Global: Views will display an error if visible on screen when `clearCurrentUserData()` is called.
- MessagingCore: `watchConversations()`, `watchConversation(withId:)` and `watchItems(ofConversationWithId:)` will send some `UserIdNotSetError` if they are active when `clearCurrentUserData()` is called.
- MessagingUI: `NablaClient.shared.messaging.views` is NOT marked `@MainActor`.
- Scheduling: Rename `Appointment.State.upcoming` to `Appointment.State.scheduled`

### Fixed

- MessagingUI: Fixed an issue in items date grouping where some date separators where missing.

## [1.0.0-alpha34] - 2023-03-13

### Added

### Changed

- Core: `NablaTheme` is marked `@MainActor`.
- MessagingUI: Methods of `InboxDelegate` and `ConversationViewControllerDelegate` are marked `@MainActor`.
- MessagingUI: `NablaClient.shared.messaging.views` is marked `@MainActor` (Reverted in `1.0.0-alpha35`).
- Scheduling: Methods of `AppointmentDetailsDelegate`, `AppointmentListDelegate` and `ScheduleAppointmentDelegate` are marked `@MainActor`.

Any `@MainActor` member should only be accessed from the `MainActor`. Apple marked `UIView` and `UIViewController` as `@MainActor` so you should not have any change to make to your code. If you are not calling those methods from a `UIView`, a `UIViewController` or SwiftUI, we encourage you to visit the official documentation to update your app.

### Fixed

- Core: Fixed an issue preventing the same current user to log in after a log out.


## [1.0.0-alpha33] - 2023-03-06

### Added

- Scheduling: support for registering a payment step. See doc for details/instructions.
- Scheduling: Replace `NablaSchedulingViewFactory.presentScheduleAppointmentNavigationController(from:delegate:)` with `NablaSchedulingViewFactory.createScheduleAppointmentNavigationController(delegate:)`.

### Changed

- Core: `NablaClient.authenticate` is replaced by `NablaClient.setCurrentUser` and `NablaClient.clearCurrentUser`. `SessionTokenProvider` is set during `NablaClient.initialize`.
- Core: Moved the `SessionTokenProvider` from `Configuration` to `NablaClient.initialize` arguments. Also changed the arguments order of `NablaClient.initialize`.
- MessagingCore: Renamed `ConversationActivity.Activity` to `ConversationActivity.Content`.
- Scheduling: Removed `Location.RemoteLocation.unknown` case.

### Fixed

- Fixed typos


## [1.0.0-alpha32] - 2023-02-14

### Added

- Core: Added a new `watchEventsConnectionState` method on `NablaClient` which allows you to monitor the current state of the network connection used to receive live events.
- Messaging Core: Added a new `Response` object returned by watchers. It contains metadata about the freshness of the data returned, allowing the caller to know if the data comes from cache or is fresh and if a background refresh is in progress.
- VideoCall: Disabled screen idling during video calls.
- VideoCall: Handle and open external video call urls when specified on appointments.

### Changed

- Messaging Core: `watchConversation(withId:)` now returns a `AnyPublisher<Response<Conversation>, NablaError>`.
- Messaging Core: `watchItems(ofConversationWithId:)` now returns a `AnyPublisher<Response<PaginatedList<ConversationItem>>, NablaError>`.
- Messaging Core: `watchConversations()` now returns a `AnyPublisher<Response<PaginatedList<Conversation>>, NablaError>`.
- Messaging UI: After sending a message in a conversation, the view will automatically scroll to it.
- Messaging UI: Increased the composer default font size.

### Fixed

- Scheduling: Months are no longer capitalized when using the french locale.
- VideoCall: Prevent a scenario where the video call screen would appear after the user hangs up.


## [1.0.0-alpha31] - 2023-02-03

### Added

### Changed

### Fixed

- Scheduling: Improved the loading indicators in the new appointment flow.
- Scheduling: Fixed appointment scheduling consents not being updated when they are already present in the cache.
- VideoCall: Fixed a bug preventing video call request messages from being displayed in the chat.


## [1.0.0-alpha30] - 2023-01-19

### Added

- Added an extra step in the "schedule appointment" flow to choose between remote and physical appointments.
- Added an appointment detail view accessible from the list of appointments. For physical appointments, this view displays the address of the appointment.
- You can now register your own `UniversalLinkGenerator` on `NablaClient.shared.scheduling.universalLinkGenerators` to let users open addresses in other apps installed on their phone.

### Changed

- Avatar view will now display a default icon image when no picture or initials are available.
- Avatar view is now exposing more customizable theme properties.
  - `NablaTheme.AvatarView.backgroundColor`: used for the background color when someone doesn't have a profile picture.
  - `NablaTheme.AvatarView.tintColor`: used to tint the initials or the default icon of someone who doesn't have a profile picture.
  - `NablaTheme.AvatarView.defaultIcon`: displayed when we don't have the profile picture nor the initials
- Core: The `Logger` interface now has an nullable `error` property for each log level. If you implemented your own custom logger you'll have to change the methods signature to migrate.
- Removed the default navigation from `NablaScheduling` views. Exposed `AppointmentListDelegate` and `AppointmentDetailsDelegate` instead so you can build the most adequate navigation for your app.

### Fixed

- Fixes a crash when opening a conversation with a video call interactive message while `NablaVideoCallModule` is not set up.
- Messaging UI: Fixed load more items animation in the conversation list view.

## [1.0.0-alpha29] - 2022-12-21

### Added

- Enable cache persistence on disk for network calls in Messaging and Scheduling modules.
- Added NablaTheme `PrimaryButtonTheme.cornerRadius` property.
- Added NablaTheme `AppointmentListViewTheme.CellTheme.cornerRadius` property.
- Added NablaTheme `CategoryPickerViewTheme.CellTheme.cornerRadius` property.
- Added NablaTheme `TimeSlotPickerViewTheme.CellTheme.cornerRadius` property.
- Added NablaTheme `TimeSlotPickerViewTheme.CellTheme.insets` property.
- Added NablaTheme `TimeSlotPickerViewTheme.CellTheme.ButtonTheme.cornerRadius` property.
- Added NablaTheme `AppointmentConfirmationTheme.headerCornerRadius` property.
- Added NablaTheme `AppointmentConfirmationTheme.captionShape` property.
- Added NablaTheme `Conversation.videoCallActionRequestIcon` property.

### Changed

- Changed spacings between cards in the appointment list, appointment category list and time slot list.

### Fixed

- Fixed some UI layout issues in the Conversation screen composer and in the Scheduling confirmation screen.
- Fixed the color of the chat's content appearing below the composer in Messaging UI module.
- Fixed a bug where some view controllers would override the global `UINavigationBar.appearance()`.
- All spinners now use the `NablaTheme.Shared.loadingViewIndicatorTintColor` color.
- Better support for screen sharing during video calls.


## [1.0.0-alpha28] - 2022-12-13

### Added

### Changed

- Messaging Core: Renamed `createDraftConversation` to `startConversation`. It keeps the behavior of creating the conversation lazily when the patient sends the first message.
- Messaging Core: `createConversation` now has a required `withMessage` argument and should be used to start a conversation on behalf of the patient with a first message from them.

### Fixed


## [1.0.0-alpha27] - 2022-12-05

### Added

### Changed

- Removed `Cancellable` and `ResultHandler` from client interfaces.
  - watchers now return some `AnyPublisher` from the `Combine` framework.
  - other methods return only once, and leverage the new `async`/`await` feature from Swift.
  
⚠️ Here is an example to migrate watchers:

```swift
// Before

private var watcher: Cancellable?

private func startWatching() {
    watcher = client.watchConversations(handler: { [weak self] result in
        // Do something with result
    })
}

// After
import Combine

private var watcher: AnyCancellable?

private func startWatching() {
    watcher = client.watchConversations()
        .sink(receiveValue: { conversations in
            // Do something with conversations
        })
}
```

You can use `sink(receiveCompletion:receiveValue:)` to catch errors. See https://developer.apple.com/documentation/combine/receiving-and-handling-events-with-combine for more details.

⚠️ Here is an example to migrate to `async`/`await`:

```swift
// Before
NablaMessagingClient.shared.markConversationAsSeen(handler: { [weak self] result in
    // Do something with result
})

// After
Task(priority: .userInitiated) {
    do {
        try await NablaMessagingClient.shared.markConversationAsSeen(conversationId)
    } catch {
        // Do something with error
    }
}
```

To learn more about `async`, `await` and `Task`: https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html.

### Fixed

- Fixed an issue preventing the watchers from automatically fetching new data after connectivity is restored.


## [1.0.0-alpha26] - 2022-11-25

### Added

### Changed

### Fixed

- Fixed a bug causing the conversation list to be visible under the tab bar and the navigation bar.
- Fixed a crash that could happen if an emoji is used in appointment consents in Scheduling module.

## [1.0.0-alpha25] - 2022-11-24

### Added

- Added an empty state when the conversation list is empty. You can customize this text appearance using `Theme.ConversationPreview.EmptyView` attributes.

### Changed

- Added a "play" indicator on videos on iOS 16 since the default one has been removed by the system update.
- The full screen image and document viewers in conversation screen are now presented modally with customizable theming.

### Fixed

- Fixed an infinite loop that could happen when `SessionTokenProvider` was returning badly formatted tokens.
- Fixed a layout issue in the conversation screen that happens when a conversation is unlocked while displayed on screen. 


## [1.0.0-alpha24] - 2022-11-17

### Added

### Changed

### Fixed

- Fixed NablaTheme.Colors being immutable.


## [1.0.0-alpha23] - 2022-11-16

### Added

- Reporting: Add an ErrorReporter to report anonymous events to nabla servers to help debug some features like video calls.

### Changed

- Removed the `showComposer` parameter from `createConversationViewController` method and relied on `Conversation` `isLocked` property to hide the composer.  
⚠️ If you were using the `showComposer` parameter of `NablaClient.shared.messaging.views.createConversationViewController`, it is not available anymore and you should migrate to using lock conversation from the Console.

### Fixed
 
- Fixed an issue in video calls where the Provider's video could sometime not be displayed.

## [1.0.0-alpha22] - 2022-11-14

### Added
- Support for dynamic consents in Scheduling module that you can customize from the console.

### Changed
- The `NablaClient.initialize` method now takes a `Configuration` struct instead of multiple params.
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
- Fix an issue where the spinner when loading more messages in the conversation screen of the Messaging UI module would not be at the correct position
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
- Renamed `NablaSchedulingViewFactory.presentScheduleAppointmentViewController` to `NablaSchedulingViewFactory.presentScheduleAppointmentNavigationController`.

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
