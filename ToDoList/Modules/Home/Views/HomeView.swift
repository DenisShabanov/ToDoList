//
//  HomeView.swift
//  ToDoList
//
//  Created by Denis Shabanov on 03.10.2025.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: State
    @State
    var textField: String = ""
    
    @State
    var isSelected: Bool = false
    
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
                ForEach(0..<10, id: \.self) { index in
                    VStack(spacing: 10) {
                        NoteFieldView(isSelected: $isSelected)
                        if index < 9 {
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
            Text("0 Задач")
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
    HomeView(isSelected: true)
}
