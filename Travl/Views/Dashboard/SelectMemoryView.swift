//
//  SelectMemoryView.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//

import SwiftUI
import CoreData

struct SelectMemoryView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var memoryViewModel: MemoryViewModel

    let trip: TripEntity

    private var availableMemories: [MemoryEntity] {

        memoryViewModel.memories
            .filter { $0.trip == nil }
            .sorted {
                ($0.date ?? .distantPast) >
                ($1.date ?? .distantPast)
            }
    }

    var body: some View {

        Group {

            if availableMemories.isEmpty {

                ContentUnavailableView(
                    "No Available Memories",
                    systemImage: "photo.stack",
                    description: Text("Create a new memory or remove one from another trip.")
                )

            } else {

                ScrollView {

                    LazyVStack(spacing: 16) {

                        ForEach(availableMemories, id: \.objectID) { memory in

                            Button {

                                attach(memory)

                            } label: {

                                MemoryCard(memory: memory)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Add Existing Memory")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func attach(_ memory: MemoryEntity) {

        memory.trip = trip

        CoreDataService.shared.saveContext()

        memoryViewModel.refresh()

        dismiss()
    }
}

#Preview {

    let context = PersistenceController.preview.container.viewContext

    let trip = TripEntity(context: context)
    trip.title = "Goa"

    let memory = MemoryEntity(context: context)
    memory.title = "Sunset"
    memory.note = "Beautiful evening"
    memory.date = .now
    memory.rating = 5
    memory.trip = nil

    return NavigationStack {

        SelectMemoryView(trip: trip)
    }
    .environmentObject(MemoryViewModel())
}
