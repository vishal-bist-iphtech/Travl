//
//  TripMemoriesSection.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI


struct TripMemoriesSection: View {

    @ObservedObject var trip: TripEntity

    @EnvironmentObject private var memoryViewModel: MemoryViewModel

    @State private var showMemoryOptions = false
    @State private var memorySheet: MemorySheet?

    enum MemorySheet: Identifiable {
        case add
        case select

        var id: Self { self }
    }

    private var memories: [MemoryEntity] {

        let set = trip.memories as? Set<MemoryEntity> ?? []

        return set.sorted {
            ($0.date ?? .distantPast) >
            ($1.date ?? .distantPast)
        }
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {
                
                Text("Memories")
                    .font(.title3.bold())
                
                Spacer()
                
                if memories.count >= 3 {
                    
                    NavigationLink("See All") {
                        
                        MemoriesView(trip: trip)
                    }
                    
                }else {
                    Button {
                        
                        showMemoryOptions = true
                        
                    } label: {
                        
                        Label("Add", systemImage: "plus")
                    }
                }
            }

            if memories.isEmpty {

                ContentUnavailableView(
                    "No Memories",
                    systemImage: "photo.stack",
                    description: Text("This trip doesn't have any memories yet.")
                )

            } else {
                
                
                TabView {
                    ForEach(memories.prefix(3), id: \.objectID) { memory in
                        NavigationLink {
                            MemoryDetailView(memory: memory)
                        } label: {
                            MemoryCard(memory: memory)
                        }
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 230)
                
                

            }
        }
        .onAppear {
            print("Memories:", trip.memories?.count ?? 0)
        }
        .confirmationDialog(
            "Add Memory",
            isPresented: $showMemoryOptions,
            titleVisibility: .visible
        ) {

            Button("Create New Memory") {

                memorySheet = .add
            }

            Button("Add Existing Memory") {

                memorySheet = .select
            }

        }
        .sheet(item: $memorySheet) { sheet in
        switch sheet {
        case .add:
            NavigationStack {
                AddMemoryView(trip: trip)
            }

        case .select:
            NavigationStack {
                SelectMemoryView(trip: trip)
                    .environmentObject(memoryViewModel)
            }
        }
    }
    .padding()
    }
}
