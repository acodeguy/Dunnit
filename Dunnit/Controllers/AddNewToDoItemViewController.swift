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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAccessibilityIdentifiers()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let title: String = titleTextField.text!
        let dueDate: Date = dueDatePicker.date
        self.delegate?.saveItem(title: title, dueDate: dueDate)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupAccessibilityIdentifiers() {
        titleTextField.accessibilityIdentifier = "AddNewToDoItem_titleTextField"
    }
}
