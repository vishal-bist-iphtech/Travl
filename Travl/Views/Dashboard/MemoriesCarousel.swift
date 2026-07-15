//
//  MemoriesCarousel.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct MemoriesCarousel: View {

    let memories: [Memory]

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                Text("Recent Memories")
                    .font(.title3)
                    .fontWeight(.bold)

                Spacer()

                Button("See all") {

                }
                .fontWeight(.semibold)
            }

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 12) {

                    ForEach(memories) { memory in

                        MemoryCard(memory: memory)
                    }
                }
            }
        }
    }
}

#Preview {
    MemoriesCarousel(memories: sampleMemories)
}
