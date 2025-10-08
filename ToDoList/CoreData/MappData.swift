//
//  MappData.swift
//  ToDoList
//
//  Created by Denis Shabanov on 06.10.2025.
//

import Foundation
import CoreData

extension CDNote {
    func toDomain() -> Note {
        Note(
            id: Int(id),
            todo: todo ?? "",
            completed: completed,
            createdAt: createdAt ?? Date()
        )
    }

    func update(from note: Note) {
        self.id = Int64(note.id)
        self.todo = note.todo
        self.completed = note.completed
        self.createdAt = note.createdAt
    }
}

extension Note {
    func toCoreData(in context: NSManagedObjectContext) -> CDNote {
        let entity = CDNote(context: context)
        entity.id = Int64(id)
        entity.todo = todo
        entity.completed = completed
        entity.createdAt = createdAt
        return entity
    }
}
