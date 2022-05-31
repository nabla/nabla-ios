import XCTest

extension XCUIApplication {
    var sendButton: XCUIElement {
        buttons["Arrow Up Circle"]
    }

    func createAndNavigateToTheNewConversation() {
        XCTContext.runActivity(named: "Create and navigate to the new conversation") { _ in
            XCTContext.runActivity(named: "Create conversation") { _ in
                buttons["compose"].tap()
            }
            XCTContext.runActivity(named: "Tap on newly created conversation") { _ in
                tables.staticTexts["PreviewTitle 1"].waitUntilExists().tap()
            }
            XCTContext.runActivity(named: "Wait for conversation title to appear") { _ in
                _ = staticTexts["Title 2"].waitUntilExistsAssert()
            }
        }
    }
}

final class ConversationViewControllerUITests: XCTestCase {
    private let textMessageContent = "Hello doctor!"
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false
    }
    
    func testTypingIndicatorAppears() throws {
        // GIVEN
        let app = XCUIApplication()
        app.addLaunchArgument(.testTypingIndicatorAppears)
        app.launch()
        app.createAndNavigateToTheNewConversation()
        
        // WHEN & THEN
        // Since we don't have accessibility hints we can not target the typing indicator view directly
        // We simply check that a provider cell exists
        XCTContext.runActivity(named: "Verify that a cell appears containung the typing indicator view") { _ in
            _ = app.cells.staticTexts["JD"].waitUntilExistsAssert()
            _ = app.cells.staticTexts["Dr Doe"].waitUntilExistsAssert()
        }
    }
    
    func testSendMessage() throws {
        // GIVEN
        let app = XCUIApplication()
        app.addLaunchArgument(.testSendMessage)
        app.launch()
        app.createAndNavigateToTheNewConversation()
        
        // WHEN & THEN
        var sendButton: XCUIElement!
        XCTContext.runActivity(named: "Verify that send button is disabled") { _ in
            sendButton = app.sendButton
            XCTAssertFalse(sendButton.isEnabled)
        }
        
        XCTContext.runActivity(named: "Type some text and verify that send button is enabled") { _ in
            let textView = app.textViews.element(boundBy: 0)
            
            textView.tap()
            textView.typeText(textMessageContent)
            XCTAssertTrue(sendButton.isEnabled)
        }
        
        XCTContext.runActivity(named: "Tap on send and assert that message is added in sending state") { _ in
            sendButton.tap()
            XCTAssertFalse(sendButton.isEnabled)
            _ = app.cells.staticTexts[textMessageContent].waitUntilExistsAssert()
            _ = app.cells.buttons["Sending…"].waitUntilExistsAssert()
        }
    }
    
    func testFailSendMessageAndRetry() throws {
        // GIVEN
        let app = XCUIApplication()
        app.addLaunchArgument(.testFailSendMessageAndRetry)
        app.launch()
        app.createAndNavigateToTheNewConversation()
        
        // WHEN & THEN
        XCTContext.runActivity(named: "Type some text and send") { _ in
            let textView = app.textViews.element(boundBy: 0)
            
            textView.tap()
            textView.typeText(textMessageContent)
            app.sendButton.tap()
        }
        
        var retryButton: XCUIElement!
        XCTContext.runActivity(named: "Wait for failure and retry") { _ in
            retryButton = app.cells.buttons["Failed to send, tap to try again…"]
            retryButton.waitUntilExists().tap()
        }
        
        XCTContext.runActivity(named: "Wait for retry button to disappear") { _ in
            _ = retryButton.waitUntilDisappearsAssert()
        }
    }
    
    func testSendMessageAndDelete() throws {
        // GIVEN
        let app = XCUIApplication()
        app.addLaunchArgument(.testSendMessageAndDelete)
        app.launch()
        app.createAndNavigateToTheNewConversation()
        
        // WHEN & THEN
        XCTContext.runActivity(named: "Type some text and send") { _ in
            let textView = app.textViews.element(boundBy: 0)
            
            textView.tap()
            textView.typeText(textMessageContent)
            app.sendButton.tap()
        }
        
        XCTContext.runActivity(named: "Long press on message and tap delete") { _ in
            app.cells.staticTexts[textMessageContent].press(forDuration: 1)
            app.buttons["Delete"].tap()
        }
        
        XCTContext.runActivity(named: "Verify that message is replaced by deleted message") { _ in
            _ = app.cells.staticTexts[textMessageContent].waitUntilDisappearsAssert()
            _ = app.cells.staticTexts["Deleted message"].waitUntilExistsAssert()
        }
    }
    
    func testSendMediaMessage() throws {
        // GIVEN
        let app = XCUIApplication()
        app.addLaunchArgument(.testSendMediaMessage)
        app.launch()
        app.createAndNavigateToTheNewConversation()
        
        // WHEN & THEN
        XCTContext.runActivity(named: "Import image from the library") { _ in
            app.buttons["camera.on.rectangle"].tap()
            app.sheets.buttons["Photo Library"].waitUntilExists().tap()
            app.scrollViews.images.element(boundBy: 1).waitUntilExists().tap()
            app.navigationBars.buttons["Add"].tap()
        }
        
        XCTContext.runActivity(named: "Send and wait for the image to appear in the list") { _ in
            app.sendButton.tap()
            XCTAssertEqual(1, app.cells.images.allElementsBoundByIndex.count)
        }
    }
    
    func testFocusOnTextMessage() throws {
        // GIVEN
        let app = XCUIApplication()
        app.addLaunchArgument(.testFocusOnTextMessage)
        app.launch()
        app.createAndNavigateToTheNewConversation()
        
        // WHEN & THEN
        XCTContext.runActivity(named: "Tap on first message and check Sent appears") { _ in
            app.staticTexts["Hello"].waitUntilExists().tap()
            app.buttons["Sent"].waitUntilExistsAssert()
        }
        
        XCTContext.runActivity(named: "Tap again and check Sent disappears") { _ in
            app.staticTexts["Hello"].waitUntilExists().tap()
            app.buttons["Sent"].waitUntilDisappearsAssert()
        }
        
        XCTContext.runActivity(named: "Tap on second message and check we have a second date separator") { _ in
            app.staticTexts["World!"].tap()
            app.buttons["Sent"].waitUntilExistsAssert()
            let dateSeparators = app.staticTexts.containing(.init(format: "label BEGINSWITH 'Today at '"))
            XCTAssertEqual(2, dateSeparators.count)
        }
    }
}
