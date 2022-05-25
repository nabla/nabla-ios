import XCTest

final class NablaUITestsHostAppUITests: XCTestCase {
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
        app.buttons["compose"].tap()
        app.tables.staticTexts["inboxPreviewTitle"].waitUntilExists().tap()
                
        // THEN
        app.staticTexts["New conversation"].waitUntilExistsAssert()
    }
}
