//
//  MockNotesAPIService.swift
//  ToDoListTests
//
//  Created by Denis Shabanov on 08.10.2025.
//

import Combine
@testable import ToDoList
import Foundation

final class MockNotesAPIService: NotesAPIServiceProtocol {
    var mockNotes: [Note] = []

    func fetchNotes() -> AnyPublisher<[Note], Error> {
        return Just(mockNotes)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
