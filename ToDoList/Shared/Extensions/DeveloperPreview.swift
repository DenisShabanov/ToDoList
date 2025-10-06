//
//  DeveloperPreview.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation

final class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    private init() {}

    var mockNotes: [Note] {
        [
            Note(id: 1, todo: "Сходить в спортзал", completed: false, userId: 1, createdAt: "25"),
            Note(id: 2, todo: "Учить SWIFT", completed: true, userId: 1, createdAt: "24"),
            Note(id: 3, todo: "Встреча с друзьями", completed: false, userId: 2, createdAt: "22")
        ]
    }

    func homeView() -> HomeView {
        let adapter = HomeViewAdapter()
        adapter.notes = mockNotes
        let presenter = HomePresenter()
        return HomeView(adapter: adapter, presenter: presenter)
    }
}
