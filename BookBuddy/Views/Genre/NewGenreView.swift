//
//  NewGenreView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 24/6/24.
//

import SwiftUI

struct NewGenreView: View {
    
    @State private var name = ""
    @State private var color = Color.red
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Name", text: $name)
                ColorPicker("set the genre color", selection: $color, supportsOpacity: false)
                Button("Create") {
                    let newGenre = Genre(name: name, color: color.toHexString()!)
                    context.insert(newGenre)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(name.isEmpty)
            }
            .background(Color.red)
            .navigationTitle("New Genre")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

#Preview {
    NewGenreView()
}
