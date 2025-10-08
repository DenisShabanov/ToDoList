//
//  Date.swift
//  ToDoList
//
//  Created by Denis Shabanov on 07.10.2025.
//

import Foundation

extension Date {
    
    private var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }
    
    func dateToString() -> String {
        return dateFormat.string(from: self)
    }
    
}
