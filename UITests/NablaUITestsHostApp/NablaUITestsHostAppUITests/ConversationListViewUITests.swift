import XCTest

final class ConversationListViewUITests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false
    }
 
    func testCreateConversation() throws {
        // GIVEN
        let app = XCUIApplication()
        app.addLaunchArgument(.testCreateConversation)
        app.launch()
        
        // WHEN
        XCTContext.runActivity(named: "Create conversation") { _ in
            app.buttons["compose"].tap()
        }
        XCTContext.runActivity(named: "Tap on newly created conversation") { _ in
            app.tables.staticTexts["PreviewTitle 1"].waitUntilExists().tap()
        }
                
        // THEN
        XCTContext.runActivity(named: "Wait for conversation title to appear") { _ in
            _ = app.staticTexts["Title 1"].waitUntilExistsAssert()
        }
    }
    
    func testConversationListPagination() throws {
        // GIVEN
        let app = XCUIApplication()
        app.addLaunchArgument(.testConversationListPagination)
        app.launch()
        
        // WHEN
        XCTContext.runActivity(named: "Wait for first conversation to appear") { _ in
            _ = app.staticTexts["PreviewTitle 1"].waitUntilExistsAssert()
        }
        XCTContext.runActivity(named: "Swipe the table up to trigger load more") { _ in
            app.tables.element(boundBy: 0).swipeUp()
        }
        
        // THEN
        XCTContext.runActivity(named: "Wait for new elements to appear") { _ in
            _ = app.staticTexts["PreviewTitle 2"].waitUntilExistsAssert()
            _ = app.staticTexts["PreviewTitle 3"].waitUntilExistsAssert()
        }
    }
}
