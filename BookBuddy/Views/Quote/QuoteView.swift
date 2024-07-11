//
//  QuoteView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 23/6/24.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    @Environment(\.modelContext) private var modelContext
    let book: Book
    
    @State private var text = ""
    @State private var page = ""
    @State private var selectedQuote: Quote?
    @Query(sort: \Quote.creationDate) var quotes: [Quote]
    
    var isEditing: Bool {
        selectedQuote != nil
    }
    
    var body: some View {
            GroupBox {
                HStack(spacing: 5) {
                    GroupBox{
                        TextField("Page #", text: $page)
                            .padding(-8)
                    }
                    Spacer()
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    
                    if isEditing {
                        Button("Cancel") {
                            text = ""
                            page = ""
                            selectedQuote = nil
                        }
                        .padding(.trailing, 8)
                        .buttonStyle(.borderless)
                        Button("Update") {
                            selectedQuote?.text = text
                            selectedQuote?.page = page.isEmpty ? nil : page
                            text = ""
                            page = ""
                            selectedQuote = nil
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(text == selectedQuote?.text)
                    } else {
                        Button("Create") {
                            let quote = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
                            book.quote?.append(quote)
                            text = ""
                            page = ""
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(text.isEmpty)
                    }
                }//: HSTACK
                TextEditor(text: $text)
                    .cornerRadius(12)
                    .frame(height: 100)
            }//: GROUPBOX
            .padding()
            List {
                ForEach(quotes) {quote in
                    VStack(alignment: .leading) {
                        Text(quote.creationDate, format: .dateTime.month().day().year())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text(quote.text)
                        
                        HStack {
                            Spacer()
                            if let page = quote.page, !page.isEmpty {
                                Text("Page: \(page)")
                            }
                        }//HSTACK
                    }//: VSTACK
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedQuote = quote
                        page = quote.page ?? ""
                        text = quote.text
                    }
                }//: LOOP
                .onDelete(perform: { indexSet in
                    withAnimation {
                        indexSet.map {quotes[$0]}.forEach(modelContext.delete)
                    }
                })
            }//: LIST
            .navigationTitle("Quotes")
            .navigationBarTitleDisplayMode(.inline)
        }
    }


#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    preview.addExamples(books)
    return NavigationStack {
        QuoteView(book: books[2])
            .modelContainer(preview.container)
    }
}



