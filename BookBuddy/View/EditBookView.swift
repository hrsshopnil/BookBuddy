//
//  EditBookView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 13/6/24.
//

import SwiftUI
import PhotosUI

struct EditBookView: View {
    
    @Environment(\.dismiss) private var dismiss
    let book: Book
    
    @State private var status: Status
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    @State private var dateAdded = Date.now
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var bookCover: PhotosPickerItem?
    @State private var bookCoverData: Data?
    
    init(book: Book) {
        self.book = book
        _status = State(initialValue: Status(rawValue: book.status)!)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    PhotosPicker(selection: $bookCover, matching: .images, photoLibrary: .shared()) {
                        Group {
                            if let bookCoverData , let uiImage = UIImage(data: bookCoverData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Image(systemName: "photo.badge.plus")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }//: GROUP
                        .frame(width: 120, height: 160)
                        .overlay(alignment: .bottomTrailing) {
                            if bookCoverData != nil {
                                Button {
                                    bookCover = nil
                                    bookCoverData = nil
                                } label: {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundStyle(.red)
                                        .font(.title)
                                }
                            }
                        }
                    }//: PHOTOSPICKER
                    VStack(spacing: 16) {
                        TextField("Title", text: $title)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.ultraThinMaterial)
                            )
                        TextField("Author", text: $author)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.ultraThinMaterial)
                            )
                        Picker("Status", selection: $status) {
                            ForEach(Status.allCases) {status in
                                Text(status.descr).tag(status)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.ultraThinMaterial)
                            
                        )
                        RatingsView(maxRating: 5, currentRating: $rating, width: 30)
                        
                        GroupBox {
                            LabeledContent {
                                switch status {
                                case .onShelf:
                                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                                case .inProgress, .completed:
                                    DatePicker("", selection: $dateAdded, in: ...dateStarted, displayedComponents: .date)
                                }
                            } label: {
                                Text("Date Created")
                            }
                            
                            if status == .inProgress || status == .completed {
                                LabeledContent {
                                    DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                                } label: {
                                    Text("Date Started")
                                }
                                if status == .completed {
                                    LabeledContent {
                                        DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                                    } label: {
                                        Text("Date Completed")
                                    }
                                }
                            }
                        }//GROUPBOX
                        .foregroundStyle(.secondary)
                        .onChange(of: status) { oldValue, newValue in
                            if newValue == .onShelf {
                                dateStarted = Date.distantPast
                                dateCompleted = Date.distantPast
                            } else if newValue == .inProgress && oldValue == .completed {
                                dateCompleted = Date.distantPast
                            } else if newValue == .inProgress && oldValue == .onShelf {
                                dateStarted = Date.now
                            } else if newValue == .completed && oldValue == .onShelf {
                                dateCompleted = Date.now
                                dateStarted = dateAdded
                            } else {
                                dateCompleted = Date.now
                            }
                        }
                        VStack(alignment: .leading){
                            Text("Summary")
                                .foregroundStyle(.secondary)
                            TextEditor(text: $summary)
                                .padding(5)
                                .frame(minHeight: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(uiColor: .tertiaryLabel), lineWidth: 2.5)
                                )
                        }
                    }
                    .padding(.horizontal, 15)
                    
                    HStack {
                        NavigationLink {
                            GenresView(book: book)
                        } label: {
                            Label("Genre", systemImage: "bookmark.fill")
                        }
                        .buttonStyle(.bordered)
                        
                        NavigationLink {
                            QuoteView(book: book)
                        } label: {
                            let count = book.quote?.count ?? 0
                            Label("\(count) Quotes", systemImage: "quote.opening")
                        }
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    .padding(.leading, 12)
                    .padding(.horizontal)
                }//: VSTACK
                
            }//: GEOMETRY READER
        }//: BODY
    }
}//: STRUCT

#Preview {
    let preview = Preview(Book.self)
    return NavigationStack {
        EditBookView(book: Book.sampleBooks[4])
            .modelContainer(preview.container)
    }
}
