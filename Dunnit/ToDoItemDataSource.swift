//
//  ToDoItemDataSource.swift
//  Dunnit
//
//  Created by Andrew on 16/06/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import CoreData

class ToDoItemDataSource {
    
    let dunnitAppContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let toDoAlertNotifier = ToDoAlertNotifier()
    
    func loadItems() -> [ToDo]? {
        var todoItems: [ToDo]?
        let toDoItemsRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do {
            todoItems = try dunnitAppContext.fetch(toDoItemsRequest)
        } catch {
            print("Error loading todo items: \(error)")
        }
        return todoItems
    }
    
    func saveItem(title: String, dueDate: Date, alertEnabled: Bool = false) {
        let newToDoItem = ToDo(context: self.dunnitAppContext)
        newToDoItem.title = title
        newToDoItem.body = ""
        newToDoItem.dueDate = dueDate
        newToDoItem.alertEnabled = alertEnabled

        do {
            try dunnitAppContext.save()
            if alertEnabled {
                toDoAlertNotifier.requestNotificationsPermissions()
                toDoAlertNotifier.createAlert(title: "Dunnit yet?", body: title, reminderDate: dueDate)
            }
        } catch {
            print("Error saving todo items: \(error)")
        }
    }
    
    func complete(toDoItem: ToDo) {
        toDoItem.completed = !toDoItem.completed
        do {
            try self.dunnitAppContext.save()
        } catch {}
    }
    
    func delete(toDoItem: ToDo) {
        dunnitAppContext.delete(toDoItem)
        do {
            try dunnitAppContext.save()
        } catch {
            print("Error deleting item: \(error)")
        }
    }
}
