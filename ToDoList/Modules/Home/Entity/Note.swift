//
//  Note.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation

struct TodoResponse: Decodable {
    let todos: [Note]
}

struct Note: Identifiable, Decodable, Equatable {
    let id: Int
    var todo: String
    var completed: Bool
    var createdAt: Date?
    
    init(id: Int, todo: String, completed: Bool, createdAt: Date? = nil) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.createdAt = createdAt
    }
}
