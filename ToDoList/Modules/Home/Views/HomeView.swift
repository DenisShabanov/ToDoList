//
//  HomeView.swift
//  ToDoList
//
//  Created by Denis Shabanov on 03.10.2025.
//

import SwiftUI

struct HomeView: View {
    
    @State
    var textField: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Задачи")
                        .font(.largeTitle)
                        .foregroundStyle(Color.theme.accent)
                        .fontWeight(.bold)
                    
                    SearchBar(textField: $textField)
                    ScrollView{
                        
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

extension HomeView {
    
    
    
}

#Preview {
    HomeView()
}
