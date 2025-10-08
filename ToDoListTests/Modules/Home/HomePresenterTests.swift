//
//  HomePresenterTests.swift
//  ToDoListTests
//
//  Created by Denis Shabanov on 08.10.2025.
//

import XCTest
@testable import ToDoList

final class HomePresenterTests: XCTestCase {

    var presenter: HomePresenter!
    var mockView: MockHomeView!
    var mockInteractor: MockHomeInteractor!
    var mockRouter: MockHomeRouter!

    override func setUp() {
        super.setUp()
        presenter = HomePresenter()
        mockView = MockHomeView()
        mockInteractor = MockHomeInteractor()
        mockRouter = MockHomeRouter()

        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    func testViewDidLoad_ShouldCallFetchNotes() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchCalled)
    }

    func testDidLoadNotes_ShouldShowNotesOnView() {
        let notes = [Note(id: 1, todo: "Test", completed: false, createdAt: Date())]
        presenter.didLoadNotes(notes)
        XCTAssertTrue(mockView.showNotesCalled)
        XCTAssertEqual(mockView.receivedNotes.first?.todo, "Test")
    }

    func testSearchNotes_ShouldFilterCorrectly() {
        let notes = [
            Note(id: 1, todo: "Buy milk", completed: false, createdAt: Date()),
            Note(id: 2, todo: "Read book", completed: false, createdAt: Date())
        ]
        presenter.didLoadNotes(notes)
        presenter.searchNotes(with: "read")
        XCTAssertEqual(mockView.receivedNotes.count, 1)
        XCTAssertEqual(mockView.receivedNotes.first?.todo, "Read book")
    }
}
