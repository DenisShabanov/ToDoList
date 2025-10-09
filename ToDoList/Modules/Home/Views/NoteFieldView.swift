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
    
    //MARK: State
    
    @State
    private var showPopover = false
    
    //MARK: Properties
    
    let title: String
    let subtitle: String
    let date: Date
    var onTap: () -> Void
    var onEdit: () -> Void
    var onShare: () -> Void
    var onDelete: () -> Void
    
    //MARK: Body
    
    var body: some View {
        HStack(alignment: .top){
            stateButton
            noteInfo
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
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
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(isSelected ? Color.theme.secondaryText : Color.theme.accent)
                .strikethrough(isSelected, color: Color.theme.secondaryText)
            Text(subtitle)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(isSelected ? Color.theme.secondaryText : Color.theme.accent)
                .lineLimit(2)
            Text(date.dateToString())
                .font(.callout)
                .foregroundStyle(Color.theme.secondaryText)
        }
        .padding(8)
        .background(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
        .contextMenu{
            Group {
                Button {
                    onEdit()
                    showPopover = false
                } label: {
                    HStack {
                        Text("Редактировать")
                        Spacer()
                        Image(systemName: "pencil")
                    }
                    .padding()
                    .foregroundStyle(Color.theme.background)
                }
                Button {
                    onShare()
                    showPopover = false
                } label: {
                    HStack {
                        Text("Поделиться")
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                    }
                    .padding()
                    .foregroundStyle(Color.theme.background)
                }
                Button {
                    onDelete()
                    showPopover = false
                } label: {
                    Label("Удалить", systemImage: "trash")
                        .foregroundStyle(Color.theme.red)
                }
                .frame(maxWidth: 400)
            }
        }
    }
}

//MARK: Preview

#Preview {
    NoteFieldView(isSelected: .constant(false), title: "", subtitle: "", date: Date(), onTap: {}, onEdit: {}, onShare: {}, onDelete: {})
}
