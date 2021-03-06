@testable import NablaMessagingCore
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupNablaMessagingProtocolMock()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    func setupNablaMessagingProtocolMock() {
        if ProcessInfo.processInfo.containsLaunchArgument(.testCreateConversation) {
            NablaMessagingClientProtocolMock.shared.setupForTestCreateConversation()
        } else if ProcessInfo.processInfo.containsLaunchArgument(.testConversationListPagination) {
            NablaMessagingClientProtocolMock.shared.setupForTestConversationListPagination()
        } else if ProcessInfo.processInfo.containsLaunchArgument(.testTypingIndicatorAppears) {
            NablaMessagingClientProtocolMock.shared.setupForTestTypingIndicatorAppears()
        } else if ProcessInfo.processInfo.containsLaunchArgument(.testSendMessage) {
            NablaMessagingClientProtocolMock.shared.setupForTestSendMessage()
        } else if ProcessInfo.processInfo.containsLaunchArgument(.testFailSendMessageAndRetry) {
            NablaMessagingClientProtocolMock.shared.setupForTestFailSendMessageAndRetry()
        } else if ProcessInfo.processInfo.containsLaunchArgument(.testSendMessageAndDelete) {
            NablaMessagingClientProtocolMock.shared.setupForTestSendMessageAndDelete()
        } else if ProcessInfo.processInfo.containsLaunchArgument(.testSendMediaMessage) {
            NablaMessagingClientProtocolMock.shared.setupForTestSendMediaMessage()
        } else if ProcessInfo.processInfo.containsLaunchArgument(.testFocusOnTextMessage) {
            NablaMessagingClientProtocolMock.shared.setupForTestFocusOnTextMessage()
        }
    }
}
