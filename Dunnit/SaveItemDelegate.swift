//
//  SaveItemDelegate.swift
//  Dunnit
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

protocol SaveItemDelegate {
    func saveItem(title: String, dueDate: Date)
}
