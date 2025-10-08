//
//  MockCoreDataService.swift
//  ToDoListTests
//
//  Created by Denis Shabanov on 08.10.2025.
//

import Foundation
@testable import ToDoList

final class MockCoreDataService: CoreDataServiceProtocol {
    var notesStorage: [Note] = []
    var addCalled = false
    var updateCalled = false
    var deleteCalled = false

    func fetchNotes() -> [Note] {
        return notesStorage
    }

    func addNote(note: Note) {
        addCalled = true
        notesStorage.append(note)
    }

    func updateNote(_ note: Note) {
        updateCalled = true
        if let index = notesStorage.firstIndex(where: { $0.id == note.id }) {
            notesStorage[index] = note
        }
    }

    func deleteNote(_ note: Note) {
        deleteCalled = true
        notesStorage.removeAll { $0.id == note.id }
    }
}
