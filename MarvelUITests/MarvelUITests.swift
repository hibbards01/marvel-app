//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Hibbard Family on 6/20/22.
//

import XCTest

final class MarvelUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launchArguments = ["-mockSessionContainer"]
        app.launch()
    }

    func testInitialState() throws {
        XCTAssertTrue(app.staticTexts["Marvel Comics"].exists)
        XCTAssertTrue(app.staticTexts["Search for a comic by ID"].exists)
        XCTAssertTrue(app.navigationBars.buttons["settings"].exists)
        XCTAssertTrue(app.searchFields["Search"].exists)
    }
    
    func testSearch() throws {
        let search = app.searchFields["Search"]
        search.tap()
        enter(text: "1234", inputElement: search)
        
        // Finally see if the comic is there.
        XCTAssertTrue(app.images["comic-image"].exists)
        XCTAssertTrue(app.staticTexts["test"].exists)
        XCTAssertTrue(app.staticTexts["description"].exists)
    }
    
    func testSettings() {
        app.navigationBars.buttons["settings"].tap()
        XCTAssertTrue(app.staticTexts["Settings"].exists)
        XCTAssertTrue(app.staticTexts["Public Key"].exists)
        XCTAssertTrue(app.staticTexts["Private Key"].exists)
        
        // Change the values.
        let textField1 = app.textFields["Enter Public Key"]
        textField1.tap()
        enter(text: "1234567", inputElement: textField1)
        let textField2 = app.textFields["Enter Private Key"]
        textField2.tap()
        enter(text: "7654321", inputElement: textField2)
        app.swipeDown(velocity: .fast)
        
        // Check if they are still the same.
        app.navigationBars.buttons["settings"].tap()
        XCTAssertEqual(String(describing: textField1.value), "Optional(1234567)")
        XCTAssertEqual(String(describing: textField2.value), "Optional(7654321)")
    }
    
    private func enter(text: String, inputElement: XCUIElement) {
        UIPasteboard.general.string = text
        inputElement.press(forDuration: 1.0)
        let paste = app.buttons["Paste"]
        _ = paste.waitForExistence(timeout: 1)
        paste.tap()
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
