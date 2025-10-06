//
//  NetworkingManager.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation
import Combine

final class NetworkingManager: NetworkingManagerProtocol {
    func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
