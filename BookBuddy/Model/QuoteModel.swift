//
//  QuoteModel.swift
//  BookBuddy
//
//  Created by shopnil hasan on 13/6/24.
//

import SwiftUI
import SwiftData

@Model
class Quote {
    var creationDate: Date = Date.now
    var text: String
    var page: String?
    var book: Book?
    
    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
}
