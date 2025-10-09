//
//  HomeRouter.swift
//  ToDoList
//
//  Created by Denis Shabanov on 06.10.2025.
//

import Foundation
import SwiftUI
import Combine

final class HomeRouter: HomeRouterProtocol, ObservableObject {
    
    // MARK:  Published states
    
    @Published var showingEditNote: Note?
    @Published var showingAddNote: Bool = false

    // MARK:  Pruvate properties
    
    private var onSaveAction: ((Note) -> Void)?
    
    // MARK:  Public Methods
    
    func presentShareSheet(for note: Note) {
        let activityVC = UIActivityViewController(activityItems: [note.todo], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
    
    func showAddNoteSheet(onSave: @escaping (Note) -> Void) {
        onSaveAction = onSave
        showingAddNote = true
    }
    
    func showEditNoteSheet(note: Note, onSave: @escaping (Note) -> Void) {
        showingEditNote = note
        onSaveAction = onSave
    }
    
    func dismiss(note: Note? = nil) {
        if let note {
            onSaveAction?(note)
        }
        showingEditNote = nil
        showingAddNote = false
    }
}
