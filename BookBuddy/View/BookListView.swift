//
//  BookListView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 13/6/24.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    
    init(sortOrder: SortOrder) {
        let sortDescriptors: [SortDescriptor<Book>] =
        switch sortOrder {
        case .status:
            [
                SortDescriptor(\Book.status),
                SortDescriptor(\Book.title)
            ]
            
        case .title:
            [SortDescriptor(\Book.title)]
            
        case .author:
            [SortDescriptor(\Book.author)]
        }

        _books = Query(sort: sortDescriptors)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                ForEach (books) {book in
                    BooksItemViews(book: book)
                }//: LOOP
            })
        }
    }
}

#Preview {
    BookListView(sortOrder: .status)
}
