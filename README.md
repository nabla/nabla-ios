# Nabla iOS SDK

The [Nabla](https://www.nabla.com/) iOS SDK makes it quick and easy to build an excellent healthcare communication experience in your iOS app. We provide powerful and customizable UI elements that can be used out-of-the-box to create a full healthcare communication experience. We also expose the low-level APIs that power those UIs so that you can build fully custom experiences.

Right now the library is in alpha, meaning all core features are here and ready to be used but API might change during the journey to a stable 1.0 version.

## Documentation

Check our [documentation portal](https://docs.nabla.com/docs/concepts-ios) for in depth documentation about integrating the SDK.

## Getting started

### Using Swift Package Manager
The Nabla Messaging UI SDK is compatible with iOS 13 and higher.

Open your .xcodeproj, select the option "Add Package..." in the File menu, and paste this URL:

```
https://github.com/nabla/nabla-ios
```

Xcode will look for the Products available in the Package. Select NablaMessagingCore and NablaMessagingUI. Press next and Xcode will download the dependencies.

You can find the latest version available in the [release page](https://github.com/nabla/nabla-ios/releases).

### Using Cocoapods

Add the following dependencies in your `Podfile`
```ruby
pod 'NablaMessagingUI'
pod 'NablaMessagingCore'
```

And then run `pod install` to update your project.


## Sample app

You can find an example of a basic integration of the Messaging UI SDK in our [demo app](https://github.com/nabla/nabla-ios/tree/main/Sample/MessagingSampleApp).

## Need more help?

If you need any help with the set-up of the SDK or the Nabla platform, please contact us on [our website](https://nabla.com). We are available to answer any question.
