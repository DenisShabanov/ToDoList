//
//  HomeView.swift
//  ToDoList
//
//  Created by Denis Shabanov on 03.10.2025.
//

import SwiftUI

protocol HomeViewProtocol: AnyObject {
    func showNotes(_ notes: [Note])
    func showError(_ message: String)
}

struct HomeView: View {
    
    //MARK: State properties
    
    @State
    var textField: String = ""
    
    @StateObject
    private var adapter: HomeViewAdapter
    
    //MARK: ObservedObject
    
    @ObservedObject
    private var router: HomeRouter
    private let presenter: HomePresenter
    
    //MARK: Init
    
    init(adapter: HomeViewAdapter, presenter: HomePresenter, router: HomeRouter) {
        _adapter = StateObject(wrappedValue: adapter)
        self.presenter = presenter
        self.router = router
    }
    
    //MARK: Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    serchBarAndHeader
                    notesList
                }
                .padding()
            }
            .safeAreaInset(edge: .bottom) {
                bottomBar
            }
            .onAppear {
                presenter.viewDidLoad()
            }
            .onChange(of: textField) { newValue in
                presenter.searchNotes(with: newValue)
            }
            .onChange(of: adapter.notes) { newNotes in
                print("Обновились заметки: \(newNotes.map { $0.todo })")
            }
            .fullScreenCover(isPresented: $router.showingAddNote) {
                AddNoteView { newNote in
                    router.dismiss(note: newNote)
                }
            }
            .fullScreenCover(item: $router.showingEditNote) { note in
                EditNoteView(note: note) { updatedNote in
                    router.dismiss(note: updatedNote)
                }
            }
        }
    }
    
}

//MARK: Layout

extension HomeView {
    
    private var serchBarAndHeader: some View {
        VStack(alignment: .leading) {
            Text("Задачи")
                .font(.system(size: 41))
                .foregroundStyle(Color.theme.accent)
                .fontWeight(.bold)
            
            SearchBar(textField: $textField)
        }
    }
    
    private var notesList: some View {
        ScrollView {
            ForEach(adapter.notes, id: \.id) { note in
                VStack(spacing: 10) {
                    NoteFieldView(isSelected: Binding(
                        get: { note.completed },
                        set: { newValue in
                            presenter.toggleNoteCompleted(note)
                        }
                    ),
                                  title: "\(note.id)",
                                  subtitle: note.todo,
                                  date: note.createdAt ?? Date(),
                                  onTap: {
                        presenter.updateNote(note)
                    }, onEdit: {
                        presenter.updateNote(note)
                    }, onShare: {
                        presenter.share(note: note)
                    }, onDelete: {
                        presenter.deleteNote(note)
                    }
                    )
                }
            }
        }
    }
    
    private var bottomBar: some View {
        HStack {
            Spacer()
            Text("\(adapter.notes.count) Задач")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            Button {
                presenter.addNoteTapped()
            } label: {
                Image(systemName: "square.and.pencil")
                    .font(.title2)
                    .foregroundStyle(Color.theme.yellow)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.theme.gray)
    }
    
}

//MARK: Preview

#Preview {
    HomeAssembly.build()
}
