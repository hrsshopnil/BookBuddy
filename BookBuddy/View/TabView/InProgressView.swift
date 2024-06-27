//
//  InProgressView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 12/6/24.
//

import SwiftUI

struct InProgressView: View {
    var body: some View {
        NavigationStack {
            BookListView(status: .inProgress)
            
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
    InProgressView()
}
