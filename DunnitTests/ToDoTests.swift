//
//  ToDoTests.swift
//  DunnitTests
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import XCTest
@testable import Dunnit

class ToDoTests: XCTestCase {
    
    func testToDoHasADefaultDueDateIfNotSupplied() {
        let todo = ToDo(title: "Testing")
        XCTAssertNotNil(todo.dueDate)
    }
}
