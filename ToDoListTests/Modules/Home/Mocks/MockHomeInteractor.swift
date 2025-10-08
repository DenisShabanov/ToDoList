//
//  MockHomeInteractor.swift
//  ToDoListTests
//
//  Created by Denis Shabanov on 08.10.2025.
//

@testable import ToDoList

final class MockHomeInteractor: HomeInteractorProtocol {
    var fetchCalled = false
    var addCalled = false

    func fetchNotes() {
        fetchCalled = true
    }

    func addNote(todo: String) {
        addCalled = true
    }

    func updateNote(_ note: Note) {}
    func deleteNote(_ note: Note) {}
}
