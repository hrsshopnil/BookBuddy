//
//  GenresView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 24/6/24.
//

import SwiftUI
import SwiftData

struct GenresView: View {
    
    @Environment (\.modelContext) private var modelContext
    @Environment (\.dismiss) private var dismiss
    @Query(sort: \Genre.name) var genres: [Genre]
    let book: Book
    @State private var newGenre = false
    
    var body: some View {
        Group {
            if genres.isEmpty {
                ContentUnavailableView {
                    Image(systemName: "bookmark.fill")
                        .font(.largeTitle)
                } description: {
                    Text("You need to create some genres first.")
                } actions: {
                    Button("Create Genre") {
                        newGenre.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                List {
                    ForEach(genres) {genre in
                        HStack {
                            if let bookGenres = book.genres {
                                Button {
                                    addRemove(genre)
                                } label: {
                                    Image(systemName: bookGenres.contains(genre) ? "circle.fill" : "circle")
                                }
                                .foregroundStyle(genre.hexColor)
                            }
                            Text(genre.name)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach {index in
                            if let bookGenre = book.genres,
                               bookGenre.contains(genres[index]),
                               let bookGenreIndex = bookGenre.firstIndex(where: {$0.id == genres[index].id}) {
                                book.genres?.remove(at: bookGenreIndex)
                            }
                            modelContext.delete(genres[index])
                        }
                    })
                    LabeledContent {
                        Button {
                            newGenre.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                        }
                        .buttonStyle(.borderedProminent)
                    } label: {
                        Text("Create new genre")
                            .foregroundStyle(.secondary).font(.caption)
                    }
                }
            }
        }
        .navigationTitle("Genres")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $newGenre, content: {
            NewGenreView()
        })
    }
    
    
    func addRemove(_ genre: Genre) {
        if let bookGenre = book.genres {
            if bookGenre.isEmpty {
                book.genres?.append(genre)
            } else {
                if bookGenre.contains(genre),
                   let index = bookGenre.firstIndex(where: {$0.id == genre.id}) {
                    book.genres?.remove(at: index)
                } else {
                    book.genres?.append(genre)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    let genres = Genre.sampleGenres
    preview.addExamples(genres)
    preview.addExamples(books)
    books[1].genres?.append(genres[0])
    return GenresView(book: books[2])
        .modelContainer(preview.container)
}
