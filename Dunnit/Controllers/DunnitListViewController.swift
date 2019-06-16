//
//  DunnitListViewController.swift
//  Dunnit
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class DunnitListViewController: UITableViewController {

    private var toDoList: [ToDo] = []
    private var todoItemDataSource = ToDoItemDataSource()
    
    @IBOutlet var addNewTodoItemBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Dunnit!"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddToDoItemViewController))
        
        loadAllItems()
        
        setupAccessibilityIdentifiers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadAllItems()
    }
    
    func loadAllItems() {
        guard let items = todoItemDataSource.loadItems() else {
            return
        }
        toDoList = items
        tableView.reloadData()
    }
    
    @objc func showAddToDoItemViewController() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewToDoItemViewController") as? AddNewToDoItemViewController else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: tableView methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoItemDataSource.delete(toDoItem: toDoList[indexPath.row])
            toDoList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoItemDataSource.complete(toDoItem: toDoList[indexPath.row])
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
    
    func setupAccessibilityIdentifiers() {
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "DunnitListViewController_addNewTodoItemBarButton"
    }
}
