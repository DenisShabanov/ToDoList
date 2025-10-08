//
//  HomeRouterProtocol.swift
//  ToDoList
//
//  Created by Denis Shabanov on 06.10.2025.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    func presentShareSheet(for note: Note)
    func showAddNoteSheet(onSave: @escaping (Note) -> Void)
    func showEditNoteSheet(note: Note, onSave: @escaping (Note) -> Void)
    func dismiss(note: Note?)
}
