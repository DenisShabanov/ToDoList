//
//  EditNoteView.swift
//  ToDoList
//
//  Created by Denis Shabanov on 06.10.2025.
//

import SwiftUI

struct EditNoteView: View {
    
    //MARK: Enviropment
    
    @Environment(\.dismiss)
    private var dismiss
    
    //MARK: State
    
    @State
    var note: Note

    // MARK:  Public properties
    
    var onSave: (Note) -> Void
    
    //MARK: Body
    
    var body: some View {
        content
    }
}

//MARK: Layout

extension EditNoteView {
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 20){
            Button {
                var updated = note
                updated.createdAt = Date()
                onSave(updated)
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Назад")
                }
                .font(.headline)
                .foregroundStyle(Color.theme.yellow)
            }
            Text("Задача №\(note.id)")
                .font(.system(size: 34))
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.accent)
            Text(note.createdAt?.dateToString() ?? "")
                .font(.callout)
                .foregroundStyle(Color.theme.secondaryText)
            TextField("Текст задачи", text: $note.todo, axis: .vertical)
                .font(.title2)
                .foregroundStyle(Color.theme.accent)
                .cornerRadius(12)
                .lineLimit(5, reservesSpace: true)
            Spacer()
        }
        .padding(20)
        .background(Color.theme.background.ignoresSafeArea())
    }
    
}

//MARK: Preview

#Preview {
    EditNoteView(note: Note(id: 1, todo: "Пример", completed: false, createdAt: Date()), onSave: {_ in })
}
