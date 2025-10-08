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
            Note(id: 1, todo: "Сходить в спортзал", completed: false, createdAt: Date()),
            Note(id: 2, todo: "Учить SWIFT", completed: true, createdAt: Date()),
            Note(id: 3, todo: "Встреча с друзьями", completed: false,  createdAt: Date())
        ]
    }

    func homeView() -> HomeView {
        let adapter = HomeViewAdapter()
        adapter.notes = mockNotes
        let presenter = HomePresenter()
        let router = HomeRouter()
        return HomeView(adapter: adapter, presenter: presenter, router: router)
    }
}
