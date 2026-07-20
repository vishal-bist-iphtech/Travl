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

    @State private var showAddMemory = false

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            if memoryViewModel.memories.isEmpty {

                ContentUnavailableView(
                    "No Memories",
                    systemImage: "photo.on.rectangle",
                    description: Text("Start capturing your favourite travel moments.")
                )

            } else {

                ScrollView {

                    LazyVStack(spacing: 16) {

                        ForEach(memoryViewModel.memories,
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
        .navigationTitle("Memories")
        .sheet(isPresented: $showAddMemory) {

            NavigationStack {

                AddMemoryView()
            }
            .environmentObject(memoryViewModel)
        }
    }
}

#Preview {


    return NavigationStack {
        MemoriesView()
    }
    .environmentObject(MemoryViewModel())
}
