//
//  Note.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation

struct Note: Identifiable {
    let id: Int
    let todo: String
    let completed: Bool
    let description: String
    
    init(id: Int, todo: String, completed: Bool, description: String) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.description = ""
    }
}
