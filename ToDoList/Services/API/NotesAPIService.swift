//
//  NotesAPIService.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation
import Combine

final class NotesAPIService: NotesAPIServiceProtocol {
    func fetchNotes() -> AnyPublisher<[Note], Error> {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TodoResponse.self, decoder: JSONDecoder())
            .map { $0.todos }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
