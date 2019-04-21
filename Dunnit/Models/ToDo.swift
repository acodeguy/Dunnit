//
//  ToDo.swift
//  Dunnit
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

class ToDo {
    
    var title: String?
    var dueDate: Date?
    
    init(title: String, dueDate: Date = Date.init()) {
        self.title = title
        self.dueDate = dueDate
    }
}