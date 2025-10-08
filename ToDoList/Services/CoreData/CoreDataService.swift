//
//  CoreDataService.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import CoreData
import UIKit

final class CoreDataService {
    static let shared = CoreDataService()
    private let container: NSPersistentContainer
    
    private var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: "CoreDataNote")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data load error: \(error)")
            }
        }
    }
    
    // MARK: Fetch Notes
    func fetchNotes() -> [Note] {
        let fetchRequest: NSFetchRequest<CDNote> = CDNote.fetchRequest()
        do {
            let cdNotes = try context.fetch(fetchRequest)
            return cdNotes.map { $0.toDomain() }
        } catch {
            print("Fetch error:", error)
            return []
        }
    }
    
    // MARK:  Add Note
    func addNote(note: Note) {
        _ = note.toCoreData(in: context)
        saveContext()
    }
    
    // MARK:  Update Note
    func updateNote(_ note: Note) {
        let fetchRequest: NSFetchRequest<CDNote> = CDNote.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", note.id)
        if let cdNote = try? context.fetch(fetchRequest).first {
            cdNote.update(from: note)
            saveContext()
        }
    }
    
    // MARK:  Delete Note
    func deleteNote(_ note: Note) {
        let fetchRequest: NSFetchRequest<CDNote> = CDNote.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", note.id)
        if let cdNote = try? context.fetch(fetchRequest).first {
            context.delete(cdNote)
            saveContext()
        }
    }
    
    //MARK: Share
    func shareNote(_ note: Note) {
        let activityVC = UIActivityViewController(activityItems: [note.todo], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
    
    // MARK:  Save
    private func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Core Data save error:", error)
        }
    }
}
