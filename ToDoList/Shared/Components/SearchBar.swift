//
//  SearchBar.swift
//  ToDoList
//
//  Created by Denis Shabanov on 03.10.2025.
//

import SwiftUI

struct SearchBar: View {
    
    //MARK: Binding
    @Binding
    var textField: String
    var onSearchChanged: ((String) -> Void)? = nil
    var onSearchTapped: (() -> Void)? = nil
    
    //MARK: Body
    var body: some View {
        HStack {
            searchButton
            searchBar
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme.gray)
        )
    }
}

//MARK: Layout
extension SearchBar {
    
    private var searchButton: some View {
        Button {
            onSearchTapped?()
        } label: {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundStyle(Color.theme.secondaryText)
        }
    }
    
    private var searchBar: some View {
        ZStack(alignment: .leading) {
            if textField.isEmpty {
                Text("Search")
                    .font(.title2)
                    .foregroundStyle(Color.theme.secondaryText.opacity(0.6))
                    .padding(.leading, 2)
            }
            TextField("", text: $textField)
                .font(.title2)
                .foregroundStyle(Color.theme.secondaryText)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .onChange(of: textField) { newValue in
                    onSearchChanged?(newValue)
                }
        }
        .overlay(
            Image(systemName: "microphone.fill")
                .font(.title2)
                .padding()
                .offset(x: 10)
                .foregroundStyle(Color.theme.secondaryText)
            , alignment: .trailing
        )
    }
}

#Preview {
    SearchBar(textField: .constant(""))
}
