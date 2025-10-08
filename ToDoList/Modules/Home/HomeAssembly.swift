//
//  HomeAssembly.swift
//  ToDoList
//
//  Created by Denis Shabanov on 06.10.2025.
//

import Foundation
import SwiftUI

enum HomeAssembly {
    static func build() -> some View {
        let adapter = HomeViewAdapter()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        presenter.view = adapter
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return HomeView(adapter: adapter, presenter: presenter, router: router)
    }
}
