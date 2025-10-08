//
//  AddNoteView.swift
//  ToDoList
//
//  Created by Denis Shabanov on 07.10.2025.
//

import SwiftUI

struct AddNoteView: View {
    //MARK: Enviropment
    @Environment(\.dismiss)
    private var dismiss
    //MARK: State
    @State
    private var text: String = ""
    
    var onSave: (Note) -> Void
    //MARK: Body
    var body: some View {
        VStack(spacing: 20) {
            saveButton
            Spacer()
            content
            Spacer()
        }
        .padding()
        .background(Color.theme.background.ignoresSafeArea())
    }
}

//MARK: Layout
extension AddNoteView {
    
    private var saveButton: some View {
        HStack{
            Button {
                let newNote = Note(
                    id: Int(Date().timeIntervalSince1970),
                    todo: text,
                    completed: false,
                    createdAt: Date()
                )
                onSave(newNote)
                dismiss()
            } label: {
                HStack{
                    Image(systemName: "chevron.left")
                    Text("Сохранить")
                }
                .font(.headline)
                .foregroundStyle(Color.theme.yellow)
            }
            Spacer()
        }
    }
    
    private var content: some View {
        VStack{
            Text("Новая заметка")
                .font(.system(size: 34))
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.accent)
            
            TextField("Введите текст заметки", text: $text)
                .padding()
                .foregroundStyle(Color.theme.accent)
                .background(Color.theme.gray)
                .cornerRadius(12)
        }
    }
    
}

//MARK: Preview
#Preview {
    AddNoteView(onSave: {_ in })
}
