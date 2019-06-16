//
//  AddNewToDoItemViewController.swift
//  Dunnit
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class AddNewToDoItemViewController: UIViewController {
    
    var delegate: SaveItemDelegate?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var alertEnabledSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveItem))
        
        title = "Add a New ToDo"
        self.setupAccessibilityIdentifiers()
    }
    
    @objc func saveItem() {
        let title: String = titleTextField.text!
        let dueDate: Date = dueDatePicker.date
        let alertChoice = alertEnabledSwitch.isOn
        delegate?.saveItem(title: title, dueDate: dueDate, alertEnabled: alertChoice)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func setupAccessibilityIdentifiers() {
        titleTextField.accessibilityIdentifier = "AddNewToDoItem_titleTextField"
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "AddNewToDoItem_SaveButton"
    }
}
