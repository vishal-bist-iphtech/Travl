//
//  RatingView.swift
//  Travl
//
//  Created by iPHTech 34 on 17/07/26.
//

import SwiftUI

struct RatingView: View {

    @Binding var rating: Int

    var maximumRating: Int = 5

    var size: Font = .title2

    var body: some View {

        HStack(spacing: 8) {

            ForEach(1...maximumRating, id: \.self) { star in

                Button {

                    withAnimation(.easeInOut(duration: 0.15)) {

                        if rating == star {

                            rating -= 1

                        } else {

                            rating = star
                        }
                    }

                } label: {

                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .foregroundStyle(.yellow)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {

    struct PreviewWrapper: View {

        @State private var rating = 4

        var body: some View {

            RatingView(rating: $rating)
                .padding()
        }
    }

    return PreviewWrapper()
}
