//
//  MemoriesView.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//
//
//  MemoriesView.swift
//  Travl
//
import SwiftUI

struct MemoriesView: View {

    @EnvironmentObject private var memoryViewModel: MemoryViewModel
    
    let trip: TripEntity?

    @State private var showAddMemory = false
    
    private var displayedMemories: [MemoryEntity] {

        if let trip {

            return memoryViewModel.memories
                .filter { $0.trip == trip }
                .sorted {
                    ($0.date ?? .distantPast) >
                    ($1.date ?? .distantPast)
                }

        } else {

            return memoryViewModel.memories
                .sorted {
                    ($0.date ?? .distantPast) >
                    ($1.date ?? .distantPast)
                }
        }
    }

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            if displayedMemories.isEmpty {

                ContentUnavailableView(
                    "No Memories",
                    systemImage: "photo.on.rectangle",
                    description: Text("Start capturing your favourite travel moments.")
                )

            } else {

                ScrollView {

                    LazyVStack(spacing: 16) {

                        ForEach(displayedMemories,
                                id: \.objectID) { memory in

                            NavigationLink {

                                MemoryDetailView(memory: memory)

                            } label: {

                                MemoryCard(memory: memory)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }

            Button {

                showAddMemory = true

            } label: {

                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 60)
                    .background(.blue)
                    .clipShape(Circle())
                    .shadow(radius: 8)
            }
            .padding()
        }
        .navigationTitle(
            trip == nil ? "Memories" : (trip?.destination ?? "Memories")
        )
        .sheet(isPresented: $showAddMemory) {
            
            NavigationStack {

                AddMemoryView(trip: trip)
                    .environmentObject(memoryViewModel)
            }
        }
    }
}

#Preview {

    NavigationStack {

        MemoriesView(trip: nil)
    }
    .environmentObject(MemoryViewModel())
}
