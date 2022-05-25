import Foundation

enum LaunchArgument: String {
    case testCreateConversation
}

extension ProcessInfo {
    func containsLaunchArgument(_ launchArgument: LaunchArgument) -> Bool {
        arguments.contains(launchArgument.rawValue)
    }
}

#if canImport(XCTest)
    import XCTest
    extension XCUIApplication {
        func addLaunchArgument(_ launchArgument: LaunchArgument) {
            launchArguments.append(launchArgument.rawValue)
        }
    }
#endif
