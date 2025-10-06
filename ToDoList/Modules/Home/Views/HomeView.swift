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
    
    //MARK: State
    @State
    var textField: String = ""
    
    @StateObject private var adapter = HomeViewAdapter()
    private let presenter: HomePresenter
    
    //MARK: Init
    init(adapter: HomeViewAdapter, presenter: HomePresenter) {
        _adapter = StateObject(wrappedValue: adapter)
        self.presenter = presenter
    }
    
    //MARK: Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                serchBarAndContent
            }
            .safeAreaInset(edge: .bottom) {
                bottomBar
            }
            .onAppear {
                presenter.viewDidLoad()
            }
        }
    }
    
}

//MARK: Layout
extension HomeView {
    
    private var serchBarAndContent: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Задачи")
                .font(.largeTitle)
                .foregroundStyle(Color.theme.accent)
                .fontWeight(.bold)
            
            SearchBar(textField: $textField)
            ScrollView {
                ForEach(Array(adapter.notes.enumerated()), id: \.element.id) { index, note in
                    VStack(spacing: 10) {
                        NoteFieldView(
                            isSelected: Binding(
                                get: { note.completed },
                                set: { newValue in
                                    adapter.notes[index].completed = newValue
                                }
                            ),
                            title: "\(note.id)",
                            subtitle: note.todo,
                            date: Date()
                        )
                        
                        if index < adapter.notes.count - 1 {
                            Divider()
                                .overlay {
                                    Color.theme.accent
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var bottomBar: some View {
        HStack {
            Spacer()
            Text("\(adapter.notes.count) Задач")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            Button {
                
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

#Preview {
    DeveloperPreview.shared.homeView()
}
