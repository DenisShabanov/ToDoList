//
//  CoreDataService.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import CoreData
import SwiftUI

final class CoreDataService: CoreDataServiceProtocol {

    // MARK:  Properties
    
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

    // MARK:  Private Methods
    
    private func backgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    // MARK:  Public Methods
    
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
    
    func addNote(note: Note) {
        let context = backgroundContext()
        context.performAndWait {
            _ = note.toCoreData(in: context)
            do { try context.save() } catch { print("Add note error:", error) }
        }
    }
    
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
    
    func shareNote(_ note: Note) {
        let activityVC = UIActivityViewController(activityItems: [note.todo], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
    
    private func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Core Data save error:", error)
        }
    }
}
