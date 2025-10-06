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

struct Note: Identifiable, Decodable {
    let id: Int
    let todo: String
    var completed: Bool
    let userId: Int?
    let createdAt: String?
}
