//
//  HomeInteractorTests.swift
//  ToDoListTests
//
//  Created by Denis Shabanov on 08.10.2025.
//

import XCTest
import Combine
@testable import ToDoList

final class HomeInteractorTests: XCTestCase {

    var interactor: HomeInteractor!
    var mockPresenter: MockHomePresenter!
    var mockCoreData: MockCoreDataService!
    var mockAPI: MockNotesAPIService!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        mockPresenter = MockHomePresenter()
        mockCoreData = MockCoreDataService()
        mockAPI = MockNotesAPIService()

        interactor = HomeInteractor(coreData: mockCoreData, notesService: mockAPI)
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockCoreData = nil
        mockAPI = nil
        super.tearDown()
    }

    func testFetchNotes_WhenLocalNotesExist_ShouldLoadFromCoreData() {
        let existingNote = Note(id: 1, todo: "Local", completed: false, createdAt: Date())
        mockCoreData.notesStorage = [existingNote]

        let expectation = self.expectation(description: "Notes loaded from CoreData")
        interactor.fetchNotes()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockPresenter.didLoadNotesCalled)
            XCTAssertEqual(self.mockPresenter.receivedNotes.first?.todo, "Local")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchNotes_WhenNoLocalNotes_ShouldFetchFromAPI() {
        mockCoreData.notesStorage = []
        mockAPI.mockNotes = [Note(id: 2, todo: "Remote", completed: false, createdAt: Date())]

        let expectation = self.expectation(description: "Notes loaded from API")
        interactor.fetchNotes()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockPresenter.didLoadNotesCalled)
            XCTAssertEqual(self.mockPresenter.receivedNotes.first?.todo, "Remote")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testAddNote_ShouldAddAndReloadNotes() {
        let expectation = self.expectation(description: "Note added and reloaded")
        interactor.addNote(todo: "New Note")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockCoreData.addCalled)
            XCTAssertTrue(self.mockPresenter.didLoadNotesCalled)
            XCTAssertEqual(self.mockPresenter.receivedNotes.first?.todo, "New Note")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testUpdateNote_ShouldUpdateAndReloadNotes() {
        let note = Note(id: 10, todo: "Old", completed: false, createdAt: Date())
        mockCoreData.notesStorage = [note]

        var updated = note
        updated.todo = "Updated"

        let expectation = self.expectation(description: "Note updated")
        interactor.updateNote(updated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockCoreData.updateCalled)
            XCTAssertEqual(self.mockCoreData.notesStorage.first?.todo, "Updated")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testDeleteNote_ShouldDeleteAndReloadNotes() {
        let note = Note(id: 5, todo: "To Delete", completed: false, createdAt: Date())
        mockCoreData.notesStorage = [note]

        let expectation = self.expectation(description: "Note deleted")
        interactor.deleteNote(note)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockCoreData.deleteCalled)
            XCTAssertTrue(self.mockPresenter.didLoadNotesCalled)
            XCTAssertTrue(self.mockCoreData.notesStorage.isEmpty)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testSearchNotes_ShouldReturnFilteredResults() {
        mockCoreData.notesStorage = [
            Note(id: 1, todo: "Buy milk", completed: false, createdAt: Date()),
            Note(id: 2, todo: "Read book", completed: false, createdAt: Date())
        ]

        let expectation = self.expectation(description: "Notes searched")
        interactor.searchNotes(with: "milk")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockPresenter.didLoadNotesCalled)
            XCTAssertEqual(self.mockPresenter.receivedNotes.count, 1)
            XCTAssertEqual(self.mockPresenter.receivedNotes.first?.todo, "Buy milk")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
