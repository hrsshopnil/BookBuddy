//
//  Enums.swift
//  BookBuddy
//
//  Created by shopnil hasan on 13/6/24.
//

import Foundation

enum Status:Int, Codable, Identifiable, CaseIterable {
    
    case onShelf, inProgress, completed
    
    var id: Self {
        self
    }
    
    var descr: String {
        switch self {
            
        case .onShelf:
            "On Shelf"
        case .inProgress:
            "Started"
        case .completed:
            "Completed"
        }
    }
}

enum SortOrder: String, Identifiable, CaseIterable {
    case title, author
    
    var id: Self {
        self
    }
}
