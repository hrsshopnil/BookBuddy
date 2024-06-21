//
//  ContentView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 12/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            OnShelfView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("On Shelf")
                }
            
            InProgressView()
                .tabItem {
                    Image(systemName: "hourglass.bottomhalf.filled")
                    Text("In Progress")
                }
            
            CompletedView()
                .tabItem {
                    Image(systemName: "checkmark.rectangle.fill")
                    Text("Completed")
                }
        }
    }
}

#Preview {
    ContentView()
        .background(.black)
}
