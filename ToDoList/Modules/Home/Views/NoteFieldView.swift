//
//  NoteFieldView.swift
//  ToDoList
//
//  Created by Denis Shabanov on 04.10.2025.
//

import SwiftUI

struct NoteFieldView: View {
    
    //MARK: Binding
    @Binding
    var isSelected : Bool
    
    //MARK: Body
    var body: some View {
        HStack(alignment: .top){
            stateButton
            noteInfo
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//MARK: Layout
extension NoteFieldView {
    
    private var stateButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isSelected.toggle()
            }
        } label: {
            ZStack {
                Circle()
                    .stroke(isSelected ? Color.theme.yellow : Color.theme.gray, lineWidth: 2)
                    .frame(width: 24)
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.theme.yellow)
                        .transition(.scale)
                }
            }
            .padding(.top, 2)
        }
        .padding(.horizontal, 4)
    }
    
    private var noteInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(isSelected ? Color.theme.secondaryText :Color.theme.accent)
                .strikethrough(isSelected, color: Color.theme.secondaryText)
            Text("Description")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(isSelected ? Color.theme.secondaryText :Color.theme.accent)
                .lineLimit(2)
            Text("Date")
                .font(.callout)
                .foregroundStyle(Color.theme.secondaryText)
        }
    }
    
}

#Preview {
    NoteFieldView(isSelected: .constant(true))
}
