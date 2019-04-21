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
        app = XCUIApplication()
        
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    func testCanAddANewToDoItemToList() {
        app.buttons["New Item"].tap()
        app.textFields["Delete Facebook profile"].tap()
        app.textFields["Delete Facebook profile"].typeText("Destroy Mark Z.")
        app.buttons["Save"].tap()
        XCTAssertTrue(app.tables.cells.staticTexts["Destroy Mark Z."].exists)
    }

}
