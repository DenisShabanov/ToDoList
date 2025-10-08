//
//  CoreDataServiceProtocol.swift
//  ToDoList
//
//  Created by Denis Shabanov on 08.10.2025.
//

import Foundation

protocol CoreDataServiceProtocol {
    func fetchNotes() -> [Note]
    func addNote(note: Note)
    func updateNote(_ note: Note)
    func deleteNote(_ note: Note)
}
