//
//  HomeViewAdapter.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation
import Combine


final class HomeViewAdapter: ObservableObject, HomeViewProtocol {

    // MARK:  Published properties

    @Published var notes: [Note] = []
    @Published var errorMessage: String?

    // MARK:  Public methods
    
    func showNotes(_ notes: [Note]) {
        DispatchQueue.main.async {
            self.notes = notes
        }
    }
    
    func showError(_ message: String) {
        self.errorMessage = message
    }
}
