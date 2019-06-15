//
//  DunnitListViewController.swift
//  Dunnit
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class DunnitListViewController: UITableViewController, SaveItemDelegate {

    private var toDoList: [ToDo] = []
    let dunnitAppContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var addNewTodoItemBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Dunnit!"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddToDoItemViewController))
        
        toDoList = self.loadItems()!
        
        setupAccessibilityIdentifiers()
    }
    
    @objc func showAddToDoItemViewController() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewToDoItemViewController") as? AddNewToDoItemViewController else {
            return
        }
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: todo item methods
    
    func saveItem(title: String, dueDate: Date, alertEnabled: Bool = false) {
        let newToDoItem = ToDo(context: self.dunnitAppContext)
        newToDoItem.title = title
        newToDoItem.body = ""
        newToDoItem.dueDate = dueDate
        newToDoItem.alertEnabled = alertEnabled
        
        do {
            try dunnitAppContext.save()
            if alertEnabled {
                createAlert(title: "Dunnit yet?", body: title, reminderDate: dueDate)
            }
            self.toDoList.append(newToDoItem)
            self.tableView.reloadData()
            self.requestNotificationsPermissions()
        } catch {
            print("Error saving todo items: \(error)")
        }
    }
    
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
    
    // MARK: tableView methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           self.dunnitAppContext.delete(self.toDoList[indexPath.row])
            do {
                try self.dunnitAppContext.save()
                self.toDoList.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .bottom)
            } catch {
                print("Error deleting todo item: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.toDoList[indexPath.row].completed = !self.toDoList[indexPath.row].completed
        do {
            try self.dunnitAppContext.save()
            
        } catch {
            print("Error marking todo item as complete: \(error)")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as UITableViewCell
        let todo = toDoList[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.dueDate?.description(with: Locale.init(identifier: "en_GB"))
        cell.accessoryType = todo.completed ? .checkmark : .none
        return cell
    }
    
    func requestNotificationsPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge])
        { (granted, error) in }
    }
    
    func createAlert(title: String, body: String, reminderDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
    
        dateComponents.day = Calendar.current.component(.day, from: reminderDate)
        dateComponents.hour = Calendar.current.component(.hour, from: reminderDate)
        dateComponents.minute = Calendar.current.component(.minute, from: reminderDate)
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
    }
    
    func setupAccessibilityIdentifiers() {
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "DunnitListViewController_addNewTodoItemBarButton"
    }
}

