//
//  BooksItemView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 13/6/24.
//

import SwiftUI
import SwiftData

struct OnShelfView: View {
    
    @State private var showNewBookView = false
    
    var body: some View {
        NavigationStack {
            BookListView(status: .onShelf)
            
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
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return OnShelfView()
        .modelContainer(preview.container)
}
