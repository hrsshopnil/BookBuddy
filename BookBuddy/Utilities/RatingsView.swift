//
//  RatingsView.swift
//  MyBooks
//
//  Created by shopnil hasan on 1/6/24.
//

import SwiftUI

public struct RatingsView: View {
    var maxRating: Int
    @Binding var currentRating: Int?
    var width:Int
    var color: Color
    var sfSymbol: String
    
    /// Only two required parameters are maxRating and the binding to currentRating.  All other parameters have default values
    /// - Parameters:
    ///   - maxRating: The maximum rating on the scale
    ///   - currentRating: A binding to the current rating variable
    ///   - width: The width of the image used for the rating  (Default - 20)
    ///   - color: The color of the image ( (Default - systemYellow)
    ///   - sfSymbol: A String representing an SFImage that has a fill variabnt (Default -  "star")
    ///
    public init(maxRating: Int, currentRating: Binding<Int?>, width: Int = 30, color: Color = Color(UIColor(.accentColor)), sfSymbol: String = "star") {
        self.maxRating = maxRating
        self._currentRating = currentRating
        self.width = width
        self.color = color
        self.sfSymbol = sfSymbol
    }

    public var body: some View {
        HStack {
                Image(systemName: sfSymbol)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.slash)
                    .foregroundStyle(Color(color))
                    .onTapGesture {
                        withAnimation{
                            currentRating = nil
                        }
                    }
                    .opacity(currentRating == 0 ? 0 : 1)
            ForEach(1...maxRating, id: \.self) { rating in
               Image(systemName: sfSymbol)
                    .resizable()
                    .font(.system(size: CGFloat(width), design: .rounded))
                    .scaledToFit()
                    .fillImage(correctImage(for: rating))
                    .foregroundStyle(Color(color))
                    .onTapGesture {
                        withAnimation{
                            currentRating = rating + 1
                        }
                    }
            }
        }.frame(width: CGFloat(maxRating * width))
    }
    
    func correctImage(for rating: Int) -> Bool {
        if let currentRating, rating < currentRating {
            return true
        } else {
            return false
        }
    }
}

struct FillImage: ViewModifier {
    let fill: Bool
    func body(content: Content) -> some View {
        if fill {
            content
                .symbolVariant(.fill)
        } else {
            content
        }
    }
}

extension View {
    func fillImage(_ fill: Bool) -> some View {
        modifier(FillImage(fill: fill))
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var currentRating: Int? = 3
        
        var body: some View {
            RatingsView(
                maxRating: 5,
                currentRating: $currentRating,
                width: 30,
                color: .accent,
                sfSymbol: "star"
            )
        }
    }
    return PreviewWrapper()
}
