//
//  BooksItemView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 13/6/24.
//

import SwiftUI
import SwiftData

struct OnShelfView: View {
    @Query(sort: \Book.title) private var books: [Book]
    @State private var showNewBookView = false
    var body: some View {
        
        
        NavigationView {
            ZStack {
                List {
                    ForEach(books) {book in
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
                            }//: VSTACK
                        }
                    }
                }//: LIST
            }//: ZSTACK
            .sheet(isPresented: $showNewBookView){
                NewBookView()
                    .presentationDetents([.medium])
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("My Books")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundStyle(.accent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewBookView = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return OnShelfView()
        .modelContainer(preview.container)
}
