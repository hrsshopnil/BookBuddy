//
//  OnShelfView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 12/6/24.
//

import SwiftUI

struct BooksItemViews: View {
    let book: Book
    @State private var selectedBookCoverData: Data?
    var body: some View {
        NavigationLink {
            EditBookView(book: book)
        } label: {
            GroupBox {
                VStack(alignment: .leading) {
                    
                    Group {
                        if let selectedBookCoverData , let uiImage = UIImage(data: selectedBookCoverData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image(systemName: "book")
                                .resizable()
                                .scaledToFit()
                            
                        }
                    }
                    
                    Text(book.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    Text(book.author)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .lineLimit(2)
                        .padding(.bottom, 1)
                    if let bookRating = book.rating {
                        HStack {
                            ForEach(0..<bookRating, id: \.self) {_ in
                                Image(systemName: "star.fill")
                                    .font(.system(size: 12))
                            }
                            
                        }//:HSTACK
                    }
                }//: VSTACK
                .frame(minWidth: 120, minHeight: 260)
            }
        }
    }
}

#Preview {
    BooksItemViews(book: Book(title: "sdalfjk", author: "aldfskj", rating: 4))
        .padding()
}
