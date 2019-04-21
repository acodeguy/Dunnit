//
//  DunnitListViewController.swift
//  Dunnit
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class DunnitListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SaveItemDelegate {

    private var toDoList: [ToDo] = []
    
    @IBOutlet weak var toDoItemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoItemsTableView.dataSource = self
        toDoItemsTableView.delegate = self
        
        self.createDummyToDoItems()
    }
    
    func saveItem(title: String, dueDate: Date) {
        print("\(dueDate): \(title)")
        let item = ToDo(title: title, dueDate: dueDate)
        toDoList.append(item)
        toDoItemsTableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newItemVC" {
            let newItemViewController = segue.destination as! AddNewToDoItemViewController
            newItemViewController.delegate = self
        }
    }
    
    // MARK: tableView methods
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoList.remove(at: indexPath.row)
            toDoItemsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as UITableViewCell
        let todo = toDoList[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.dueDate?.description(with: Locale.init(identifier: "en_GB"))
        return cell
    }
    
    func createDummyToDoItems() {
        let item1 = ToDo(title: "DDoS Attack on Facebook")
        toDoList.append(item1)
    }

}

