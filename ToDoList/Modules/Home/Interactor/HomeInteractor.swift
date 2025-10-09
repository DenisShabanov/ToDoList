//
//  HomeInteractor.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation
import Combine

final class HomeInteractor: HomeInteractorProtocol {

    // MARK:  Properties
    var presenter: HomePresenterProtocol?
    private let notesService: NotesAPIServiceProtocol
    private let coreData: CoreDataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    
    init(coreData: CoreDataServiceProtocol = CoreDataService.shared,
         notesService: NotesAPIServiceProtocol = NotesAPIService()) {
        self.coreData = coreData
        self.notesService = notesService
    }
    
    // MARK: Fetch Notes
    func fetchNotes() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let localNotes = self.coreData.fetchNotes()
            if !localNotes.isEmpty {
                DispatchQueue.main.async {
                    self.presenter?.didLoadNotes(localNotes)
                }
                return
            }
            
            self.notesService.fetchNotes()
                .subscribe(on: DispatchQueue.global(qos: .background))
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        DispatchQueue.main.async {
                            self.presenter?.didFailLoadingNotes(error)
                        }
                    }
                }, receiveValue: { notes in
                    DispatchQueue.global(qos: .userInitiated).async {
                        notes.forEach { self.coreData.addNote(note: $0) }
                        let savedNotes = self.coreData.fetchNotes()
                        DispatchQueue.main.async {
                            self.presenter?.didLoadNotes(savedNotes)
                        }
                    }
                })
                .store(in: &self.cancellables)
        }
    }
    
    // MARK: Add Note
    func addNote(todo: String) {
        let newNote = Note(
            id: Int(Date().timeIntervalSince1970),
            todo: todo,
            completed: false,
            createdAt: Date()
        )
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.coreData.addNote(note: newNote)
            let notes = self?.coreData.fetchNotes() ?? []
            DispatchQueue.main.async {
                self?.presenter?.didLoadNotes(notes)
            }
        }
    }
    
    // MARK: Update Note
    func updateNote(_ note: Note) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.coreData.updateNote(note)
            let notes = self?.coreData.fetchNotes() ?? []
            DispatchQueue.main.async {
                self?.presenter?.didLoadNotes(notes)
            }
        }
    }
    
    // MARK: Delete Note
    func deleteNote(_ note: Note) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.coreData.deleteNote(note)
            let notes = self?.coreData.fetchNotes() ?? []
            DispatchQueue.main.async {
                self?.presenter?.didLoadNotes(notes)
            }
        }
    }
    
    // MARK: Search Notes
    func searchNotes(with query: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let allNotes = self.coreData.fetchNotes()
            let filtered = query.isEmpty ? allNotes :
            allNotes.filter { $0.todo.localizedCaseInsensitiveContains(query) }
            DispatchQueue.main.async {
                self.presenter?.didLoadNotes(filtered)
            }
        }
    }
}
