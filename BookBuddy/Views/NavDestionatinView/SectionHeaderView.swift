//
//  SectionHeaderView.swift
//  BookBuddy
//
//  Created by shopnil hasan on 11/7/24.
//

import SwiftUI

struct SectionHeaderView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 15))
            .fontWeight(.semibold)
            .foregroundStyle(.gray)
    }
}

#Preview {
    SectionHeaderView(title: "name")
}
