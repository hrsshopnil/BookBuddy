//
//  GenreStackView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 25/6/24.
//

import SwiftUI

struct GenreStackView: View {
    var genres: [Genre]
    var body: some View {
        HStack {
            ForEach(genres.sorted(using: KeyPathComparator(\Genre.name))) {genre in
                Text(genre.name)
                    .font(.subheadline)
                    .padding(4)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundStyle(genre.hexColor))
            }
        }
    }
}

#Preview {
    GenreStackView(genres: [Genre(name: "fiction", color: "fffff")])
}
