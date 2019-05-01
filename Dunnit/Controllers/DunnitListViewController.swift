//
//  DunnitListViewController.swift
//  Dunnit
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import UserNotifications

class DunnitListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SaveItemDelegate {

    private var toDoList: [ToDo] = []
    
    @IBOutlet weak var toDoItemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoItemsTableView.dataSource = self
        toDoItemsTableView.delegate = self
        
        self.createDummyToDoItems()
        
        self.requestNotificationsPermissions()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newItemVC" {
            let newItemViewController = segue.destination as! AddNewToDoItemViewController
            newItemViewController.delegate = self
        }
    }
    
    // MARK: delete methods
    
    func saveItem(title: String, dueDate: Date, alertEnabled: Bool = false) {
        let item = ToDo(title: title, dueDate: dueDate)
        if alertEnabled {
            createAlert(title: "Dunnit yet?", body: title, reminderDate: dueDate)
        }
        toDoList.append(item)
        toDoItemsTableView.reloadData()
    }
    
    // MARK: tableView methods
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoList.remove(at: indexPath.row)
            toDoItemsTableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.toDoList[indexPath.row].toggleComplete()
        self.toDoItemsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as UITableViewCell
        let todo = toDoList[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.dueDate?.description(with: Locale.init(identifier: "en_GB"))
        cell.accessoryType = todo.isCompleted() ? .checkmark : .none
        return cell
    }
    
    func createDummyToDoItems() {
        let item1 = ToDo(title: "DDoS Attack on Facebook")
        toDoList.append(item1)
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

}

