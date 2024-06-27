//
//  CompletedView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 12/6/24.
//

import SwiftUI

struct CompletedView: View {
    var body: some View {
        NavigationStack {
            BookListView(status: .completed)
            
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("My Books")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundStyle(.accent)
                    }
                }
        }
    }
}

#Preview {
    CompletedView()
}
