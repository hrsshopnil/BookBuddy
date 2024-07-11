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
    @Query(sort: \Book.title) private var books: [Book]
    let status: Status
    
    var body: some View {
        List {
            ForEach(books) {book in
                if book.status == status.rawValue {
                    NavigationLink {
                        EditBookView(book: book)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .foregroundStyle(.accent)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Text(book.author)
                                .padding(.bottom, 4)
                                .foregroundStyle(.secondary)
                                .font(.callout)
                                .fontWeight(.semibold)
                            if let rating = book.rating {
                                HStack {
                                    ForEach(1..<rating, id: \.self) {_ in
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 13))
                                            .foregroundStyle(.accent)
                                    }
                                }
                            }
                        }
                    }
                }
            }//:LOOP
        }//: LIST
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookListView(status: .onShelf)
        .modelContainer(preview.container)
}
