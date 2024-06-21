//
//  GenreSample.swift
//  MyBooks
//
//  Created by shopnil hasan on 7/6/24.
//

import Foundation
import SwiftData

extension Genre {
    static var sampleGenres: [Genre] {
        [
            Genre(name: "Fiction", color: "00FF00"),
            Genre(name: "Non-Fiction", color: "0000FF"),
            Genre(name: "Romance", color: "FF0000"),
            Genre(name: "Thriller", color: "000000")
        ]
    }
}
