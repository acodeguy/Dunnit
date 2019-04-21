//
//  DunnitUITests.swift
//  DunnitUITests
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import XCTest

class DunnitUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }

    func testCanAddANewToDoItemToList() {
        app.buttons["New Item"].tap()
        app.textFields["AddNewToDoItem_titleTextField"].tap()
        app.textFields["AddNewToDoItem_titleTextField"].typeText("Destroy Mark Z.")
        app.buttons["Save"].tap()
        XCTAssertTrue(app.tables.cells.staticTexts["Destroy Mark Z."].exists)
    }

    func testDeleteToDoItemToList() {
        app.buttons["New Item"].tap()
        app.textFields["AddNewToDoItem_titleTextField"].tap()
        app.textFields["AddNewToDoItem_titleTextField"].typeText("Delete Me")
        app.buttons["Save"].tap()
        app.tables.staticTexts["Delete Me"].swipeLeft()
        app.tables.buttons["Delete"].tap()
        XCTAssertFalse(app.tables.cells.staticTexts["Delete Me"].exists)
    }
}
