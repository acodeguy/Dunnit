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
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }

    func testCanAddANewToDoItemToList() {
        let sampleItemTitle = "Buy Milk"
        self.addASampleToDoItem(title: sampleItemTitle)
        XCTAssertTrue(app.tables.cells.staticTexts[sampleItemTitle].exists)
    }

    func testDeleteToDoItemFromList() {
        let sampleItemTitle = "Buy apples"
        self.addASampleToDoItem(title: sampleItemTitle)
        app.tables.cells.staticTexts[sampleItemTitle].swipeLeft()
        app.tables.cells.buttons["Delete"].tap()
        XCTAssertFalse(app.tables.cells.staticTexts[sampleItemTitle].exists)
    }
    
    func testCanMarkToDoItemAsComplete() {
        let sampleItemTitle = "Buy shower gel"
        addASampleToDoItem(title: sampleItemTitle)
        self.completeToDoItem(withTitle: sampleItemTitle)
    }
       
    // MARK: helper methods
    
    func addASampleToDoItem(title: String) {
        app.buttons["DunnitListViewController_addNewTodoItemBarButton"].tap()
        app.textFields["AddNewToDoItem_titleTextField"].tap()
        app.textFields["AddNewToDoItem_titleTextField"].typeText(title)
        app.buttons["AddNewToDoItem_SaveButton"].tap()
    }
    
    func completeToDoItem(withTitle: String) {
        app.tables.cells.staticTexts[withTitle].tap()
    }
}
