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
        let sampleItemTitle = "Take Zuck to Court"
        self.addASampleToDoItem(title: sampleItemTitle)
        XCTAssertTrue(app.tables.cells.staticTexts[sampleItemTitle].exists)
    }

    func testDeleteToDoItemToList() {
        let sampleItemTitle = "Put Zuck in Prison"
        self.addASampleToDoItem(title: sampleItemTitle)
        app.tables.cells.staticTexts[sampleItemTitle].swipeLeft()
        app.tables.cells.buttons["Delete"].tap()
        XCTAssertFalse(app.tables.cells.staticTexts[sampleItemTitle].exists)
    }
    
    func testCanMarkToDoItemAsComplete() {
        let sampleItemTitle = "Send Zuck Some Anthrax"
        addASampleToDoItem(title: sampleItemTitle)
        self.completeToDoItem(withTitle: sampleItemTitle)
    }
    
    // MARK: helper methods
    
    func addASampleToDoItem(title: String) {
        app.buttons["New Item"].tap()
        app.textFields["AddNewToDoItem_titleTextField"].tap()
        app.textFields["AddNewToDoItem_titleTextField"].typeText(title)
        app.buttons["Save"].tap()
    }
    
    func completeToDoItem(withTitle: String) {
        app.tables.cells.staticTexts[withTitle].tap()
    }
}
