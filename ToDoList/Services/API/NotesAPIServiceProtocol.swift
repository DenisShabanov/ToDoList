//
//  NotesAPIServiceProtocol.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation
import Combine

protocol NotesAPIServiceProtocol {
    func fetchNotes() -> AnyPublisher<[Note], Error>
}
