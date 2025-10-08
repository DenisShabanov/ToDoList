//
//  MockHomePresenter.swift
//  ToDoListTests
//
//  Created by Denis Shabanov on 08.10.2025.
//

@testable import ToDoList

final class MockHomePresenter: HomePresenterProtocol {
    var didLoadNotesCalled = false
    var didFailCalled = false
    var receivedNotes: [Note] = []

    func viewDidLoad() { }

    func didLoadNotes(_ notes: [Note]) {
        didLoadNotesCalled = true
        receivedNotes = notes
    }

    func didFailLoadingNotes(_ error: Error) {
        didFailCalled = true
    }

    func addNoteTapped() { }
    func toggleNoteCompleted(_ note: Note) { }
    func share(note: Note) { }
    func deleteNote(_ note: Note) { }
    func updateNote(_ note: Note) { }
    func searchNotes(with query: String) { }
}
