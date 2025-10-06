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
    
    func viewDidLoad() {
        interactor?.fetchNotes()
    }
    
    func didLoadNotes(_ notes: [Note]) {
        view?.showNotes(notes)
    }
    
    func didFailLoadingNotes(_ error: Error) {
        view?.showError(error.localizedDescription)
    }
}
