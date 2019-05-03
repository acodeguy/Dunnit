//
//  ToDoTests.swift
//  DunnitTests
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import XCTest
import CoreData
@testable import Dunnit

class ToDoTests: XCTestCase {
    
    private var appTestContext: NSManagedObjectContext?
    
    override func setUp() {
        super.setUp()
        
        appTestContext = createInMemoryManagedObjectContext()
        
    }
    
    func testDueDateIsNilOnCreation() {
        let todo = ToDo(context: appTestContext!)
        XCTAssertNil(todo.dueDate)
    }
    
    func testCompletedIsFalseOnCreation() {
        let todo = ToDo(context: appTestContext!)
        XCTAssertFalse(todo.completed)
    }
    
    func testAlertIsDisabledOnCreation() {
        let todo = ToDo(context: appTestContext!)
        XCTAssertFalse(todo.alertEnabled)
    }
    
    func createInMemoryManagedObjectContext() -> NSManagedObjectContext? {
        
        guard let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main]) else { return nil }
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Error creating test core data store: \(error)")
            return nil
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
}
