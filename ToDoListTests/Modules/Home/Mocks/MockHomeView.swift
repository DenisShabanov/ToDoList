//
//  MockHomeView.swift
//  ToDoListTests
//
//  Created by Denis Shabanov on 08.10.2025.
//

@testable import ToDoList

final class MockHomeView: HomeViewProtocol {
    var showNotesCalled = false
    var showErrorCalled = false
    var receivedNotes: [Note] = []

    func showNotes(_ notes: [Note]) {
        showNotesCalled = true
        receivedNotes = notes
    }

    func showError(_ message: String) {
        showErrorCalled = true
    }
}
