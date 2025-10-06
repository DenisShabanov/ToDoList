//
//  HomeInteractor.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation
import Combine

final class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenter?
    private let notesService = NotesAPIService()
    private var cancellables = Set<AnyCancellable>()

    func fetchNotes() {
        notesService.fetchNotes()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.presenter?.didFailLoadingNotes(error)
                    }
                },
                receiveValue: { notes in
                    self.presenter?.didLoadNotes(notes)
                }
            )
            .store(in: &cancellables)
    }
}
