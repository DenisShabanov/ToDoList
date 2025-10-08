//
//  HomePresenter.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    private var allNotes: [Note] = []
    
    func viewDidLoad() {
        interactor?.fetchNotes()
    }
    
    func didLoadNotes(_ notes: [Note]) {
        allNotes = notes
        view?.showNotes(notes)
    }
    
    func didFailLoadingNotes(_ error: Error) {
        view?.showError(error.localizedDescription)
    }
    
    func toggleNoteCompleted(_ note: Note) {
        var updatedNote = note
        updatedNote.completed.toggle()
        interactor?.updateNote(updatedNote)
    }
    
    func share(note: Note) {
        router?.presentShareSheet(for: note)
    }
    
    func deleteNote(_ note: Note) {
        interactor?.deleteNote(note)
    }
    
    func updateNote(_ note: Note) {
        router?.showEditNoteSheet(note: note) { [weak self] updatedNote in
            self?.interactor?.updateNote(updatedNote)
        }
    }
    
    func searchNotes(with query: String) {
        let filtered = query.isEmpty ? allNotes :
        allNotes.filter { $0.todo.localizedCaseInsensitiveContains(query) }
        view?.showNotes(filtered)
    }
    
    func addNoteTapped() {
        router?.showAddNoteSheet { [weak self] newNote in
            self?.interactor?.addNote(todo: newNote.todo)
        }
    }
}
