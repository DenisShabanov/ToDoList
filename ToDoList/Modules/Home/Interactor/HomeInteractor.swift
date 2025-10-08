//
//  HomeInteractor.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation
import Combine

final class HomeInteractor: HomeInteractorProtocol {
    
    //MARK: Properties
    var presenter: HomePresenter?
    private let notesService = NotesAPIService()
    private var cancellables = Set<AnyCancellable>()
    private let coreData = CoreDataService.shared
    
    // MARK:  Fetch Notes
    func fetchNotes() {
        let localNotes = coreData.fetchNotes()
        
        if !localNotes.isEmpty {
            presenter?.didLoadNotes(localNotes)
            return
        }
        
        notesService.fetchNotes()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.presenter?.didFailLoadingNotes(error)
                    }
                },
                receiveValue: { notes in
                    notes.forEach { self.coreData.addNote(note: $0) }
                    self.presenter?.didLoadNotes(self.coreData.fetchNotes())
                }
            )
            .store(in: &cancellables)
    }
    
    // MARK:  Add Note
    func addNote(todo: String) {
        let newNote = Note(
            id: Int(Date().timeIntervalSince1970),
            todo: todo,
            completed: false,
            createdAt: Date()
        )
        coreData.addNote(note: newNote)
        presenter?.didLoadNotes(coreData.fetchNotes())
    }
    
    // MARK:  Update Note
    func updateNote(_ note: Note) {
        coreData.updateNote(note)
        presenter?.didLoadNotes(coreData.fetchNotes())
    }
    
    // MARK:  Delete Note
    func deleteNote(_ note: Note) {
        coreData.deleteNote(note)
        presenter?.didLoadNotes(coreData.fetchNotes())
    }
    
}
