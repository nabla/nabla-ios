#  Nabla iOS SDK demo app

This app contains a basic setup of the iOS Nabla SDK so that you can quickly 
test the features using our setup guide in the console.

## Prerequisites

This guide assumes that you already have access to the Nabla console. If you don't,
you need to register an organization at https://nabla.com/

You'll also need a working installation of Xcode to build the app.

## Setup

1. Clone the repository
2. Head to [https://`your_organisation_id`.pro.nabla.com/developers/sdk-setup-guide]()
3. Follow the setup guide to get your public API key and temporaries `access_token` and `refresh_token` to use for the demo

> At this stage, you should have a public API key and 2 tokens

4. Paste your API key in place of the `<yourapikey>` placeholder in the [AppDelegate](https://github.com/nabla/nabla-ios/blob/main/Example/NablaExampleApp/NablaExampleApp/AppDelegate.swift)
5. Paste your `access_token` and `refresh_token` in place of `<youraccesstoken>` and `<yourrefreshtoken>` placeholders in the [`FakeAuthenticator` class](https://github.com/nabla/nabla-ios/blob/main/Example/NablaExampleApp/NablaExampleApp/FakeAuthenticator.swift)
6. Build and run

You should now be able to use the demo app to create a new conversation and send messages.

## Next step: integrate the SDK in your app

To integrate the SDK into your app, follow our [README](https://github.com/nabla/nabla-ios) and get all the details in our [developer documentation](https://docs.nabla.com/docs/setup-1). 

## Need more help?

If you need any help with the set-up of the SDK or the Nabla platform, please contact us on [our website](https://nabla.com). We are available to answer any question.
