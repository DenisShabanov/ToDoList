//
//  NetworkingManagerProtocol.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation
import Combine

protocol NetworkingManagerProtocol {
    func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error>
}
