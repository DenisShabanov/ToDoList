//
//  MockHomeRouter.swift
//  ToDoListTests
//
//  Created by Denis Shabanov on 08.10.2025.
//

import Foundation
@testable import ToDoList

final class MockHomeRouter: HomeRouterProtocol {
    var presentShareSheetCalled = false
    var showAddNoteSheetCalled = false
    var showEditNoteSheetCalled = false
    var dismissCalled = false

    func presentShareSheet(for note: Note) {
        presentShareSheetCalled = true
    }

    func showAddNoteSheet(onSave: @escaping (Note) -> Void) {
        showAddNoteSheetCalled = true
    }

    func showEditNoteSheet(note: Note, onSave: @escaping (Note) -> Void) {
        showEditNoteSheetCalled = true
    }

    func dismiss(note: Note?) {
        dismissCalled = true
    }
}

