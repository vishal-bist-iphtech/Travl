//
//  MemoryDetailView.swift
//  Travl
//
//  Created by iPHTech 34 on 17/07/26.
//

import SwiftUI
import CoreData

struct MemoryDetailView: View {
    
    @ObservedObject var memory: MemoryEntity
    
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject private var memoryViewModel: MemoryViewModel

    @State private var showDeleteAlert = false


    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                // MARK: Photo

                ZStack(alignment: .topTrailing) {

                    Group {

                        if let data = memory.imageData,
                           let image = UIImage(data: data) {

                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 20))

                        } else {

                            RoundedRectangle(cornerRadius: 20)
                                .fill(.gray.opacity(0.15))
                                .frame(height: 250)
                                .overlay {

                                    Image(systemName: "photo")
                                        .font(.system(size: 60))
                                        .foregroundStyle(.gray)
                                }
                        }
                    }

                    Button {

                        memoryViewModel.toggleFavorite(for: memory)

                    } label: {

                        Image(systemName: memory.isFavorite ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundStyle(memory.isFavorite ? .red : .white)
                            .padding(10)
                            .clipShape(Circle())
                    }
                    .padding()
                }

                // MARK: Details

                VStack(alignment: .leading, spacing: 12) {

                    Text(memory.title ?? "")
                        .font(.largeTitle.bold())

                    HStack {

                        Image(systemName: "calendar")

                        Text(memory.date ?? .now, style: .date)
                    }

                    HStack {

                        ForEach(0..<5, id: \.self) { index in

                            Image(systemName:
                                    index < Int(memory.rating)
                                    ? "star.fill"
                                    : "star")
                        }
                        .foregroundStyle(.yellow)
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 8) {

                    Text("Notes")
                        .font(.headline)

                    Text(memory.note ?? "No notes available.")
                }
            }
            .padding()
            
        }
        .navigationTitle("Memory")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                NavigationLink {

                    EditMemoryView(memory: memory)
                        .environmentObject(memoryViewModel)

                } label: {

                    Image(systemName: "square.and.pencil")
                }

                Button(role: .destructive) {

                    showDeleteAlert = true

                } label: {

                    Image(systemName: "trash")
                }
            }
        }
        .alert("Delete Memory?", isPresented: $showDeleteAlert) {

            Button("Delete", role: .destructive) {
                
                if memory.trip != nil {
                    memory.trip = nil
                    
                    CoreDataService.shared.saveContext()

                    memoryViewModel.refresh()
                    
                    print("trip -\\-> memory \n\(memory.trip)")
                }
                else {
                    memoryViewModel.deleteMemory(memory)
                   
                }
                dismiss()
            }

            Button("Cancel", role: .cancel) { }

        } message: {

            Text("This action cannot be undone.")
        }
        
    }
}


#Preview {

    let context = PersistenceController.shared.container.viewContext

    let trip = TripEntity(context: context)
    trip.title = "Goa"
    trip.country = "India"

    let memory = MemoryEntity(context: context)
    memory.title = "Sunset"
    memory.note = "Beautiful evening."
    memory.rating = 5
    memory.date = .now
    memory.trip = trip

    return NavigationStack {

        MemoryDetailView(memory: memory)
    }
    .environmentObject(MemoryViewModel())
}
