//
//  MemoryCard.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct MemoryCard: View {

    let memory: Memory

    var body: some View {

        ZStack {

            Image("goa")
                .resizable()
                .scaledToFill()

            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.65)
                ],
                startPoint: .center,
                endPoint: .bottom
            )

            VStack {

                HStack {

                    Spacer()

                    if memory.isFavorite {

                        Image(systemName: "heart.fill")
                            .font(.caption)
                            .foregroundStyle(.red)
                            .padding(6)
                    }
                }

                Spacer()

                HStack {

                    Text(memory.title)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Spacer()
                }
            }
            .padding(8)
        }
        .frame(width: 110, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    MemoryCard(memory: sampleMemories[0])
}
