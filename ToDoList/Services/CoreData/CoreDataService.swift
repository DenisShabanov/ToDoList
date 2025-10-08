//
//  CoreDataService.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import CoreData
import SwiftUI

final class CoreDataService: CoreDataServiceProtocol {
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
    
    private func backgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    // MARK: Fetch Notes
    func fetchNotes() -> [Note] {
        var result: [Note] = []
        let semaphore = DispatchSemaphore(value: 0)
        
        let context = backgroundContext()
        context.perform {
            let request: NSFetchRequest<CDNote> = CDNote.fetchRequest()
            do {
                let cdNotes = try context.fetch(request)
                result = cdNotes.map { $0.toDomain() }
            } catch {
                print("Fetch error:", error)
            }
            semaphore.signal()
        }
        semaphore.wait()
        return result
    }
    
    // MARK:  Add Note
    func addNote(note: Note) {
        let context = backgroundContext()
        context.performAndWait {
            _ = note.toCoreData(in: context)
            do { try context.save() } catch { print("Add note error:", error) }
        }
    }
    
    // MARK:  Update Note
    func updateNote(_ note: Note) {
        let context = backgroundContext()
        context.performAndWait {
            let request: NSFetchRequest<CDNote> = CDNote.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", note.id)
            if let cdNote = try? context.fetch(request).first {
                cdNote.update(from: note)
                do { try context.save() } catch { print("Update error:", error) }
            }
        }
    }
    
    // MARK:  Delete Note
    func deleteNote(_ note: Note) {
        let context = backgroundContext()
        context.performAndWait {
            let request: NSFetchRequest<CDNote> = CDNote.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", note.id)
            if let cdNote = try? context.fetch(request).first {
                context.delete(cdNote)
                do { try context.save() } catch { print("Delete error:", error) }
            }
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
