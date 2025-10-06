//
//  HomePresenterProtocol.swift
//  ToDoList
//
//  Created by Denis Shabanov on 05.10.2025.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didLoadNotes(_ notes: [Note])
    func didFailLoadingNotes(_ error: Error)
}
