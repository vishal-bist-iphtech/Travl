//
//  MemoryCarousel.swift
//  Travl
//
//  Created by iPHTech 34 on 17/07/26.
//
//

import SwiftUI
import CoreData

struct MemoryCarousel: View {
    
    let memories: [MemoryEntity]

    @EnvironmentObject private var memoryViewModel: MemoryViewModel
    let trip: TripEntity?

    @State private var showAddMemory = false

    var body: some View {

        VStack(alignment: .leading) {

            HStack {

                Text("All Memories")
                    .font(.title2.bold())

                Spacer()

                if memories.isEmpty {

                    Button("Add Memory") {
                        showAddMemory = true
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.blue)

                } else {

                    NavigationLink {

                        MemoriesView(trip: nil)

                    } label: {

                        Text("See More")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.blue)
                    }
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showAddMemory) {

                NavigationStack {
                    AddMemoryView(trip: trip)
                }
                .environmentObject(memoryViewModel)
            }

            if memories.isEmpty {

                ContentUnavailableView(
                    "No Memories Yet",
                    systemImage: "photo.stack",
                    description: Text("Capture your favourite travel moments.")
                )
                .frame(height: 220)

            } else {

                ScrollView(.horizontal, showsIndicators: false) {

                    HStack(spacing: 16) {

                        ForEach(memories, id: \.objectID) { memory in

                            NavigationLink {

                                MemoryDetailView(
                                    memory: memory
                                )

                            } label: {

                                MemoryCard(memory: memory)
                                    .frame(width: 320)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    
    let context = PersistenceController.preview.container.viewContext

    let memory = MemoryEntity(context: context)
    memory.title = "My First Memory"
    memory.isFavorite = true
    memory.date = Date()
    memory.note = "Beautiful Valley of flowers"
    memory.rating = 4
    
     return MemoryCarousel(
            memories: [memory],
            trip: nil
        )
     .padding()
        .environmentObject(MemoryViewModel())
}
