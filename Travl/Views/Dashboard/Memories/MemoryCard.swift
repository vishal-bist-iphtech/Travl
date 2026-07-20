//
//  MemoryCard.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

//
//  MemoryCard.swift
//  Travl
//

import SwiftUI
import CoreData

struct MemoryCard: View {
    
    @EnvironmentObject private var memoryViewModel: MemoryViewModel

    @ObservedObject var memory: MemoryEntity

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            ZStack(alignment: .topTrailing) {
                
                if let imageData = memory.imageData,
                   let uiImage = UIImage(data: imageData) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .clipped()
                    
                } else {
                    
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 170)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                            
                        )
                }
                Button {
                    
                    memoryViewModel.toggleFavorite(for: memory)
                    
                } label: {
                    
                    Image(systemName: memory.isFavorite ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundStyle(memory.isFavorite ? .red : .white)
                        .padding(10)
                }
                .padding()
            }
            .frame(height: 170)


            VStack(alignment: .leading, spacing: 6) {

                HStack {

                    Text(memory.title ?? "")
                        .font(.headline)

                    Spacer()

                    HStack(spacing: 2) {

                        ForEach(0..<Int(memory.rating), id: \.self) { _ in

                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .font(.caption)
                        }
                    }
                }

                Text(
                    memory.date ?? Date(),
                    style: .date
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                if let note = memory.note,
                   !note.isEmpty {

                    Text(note)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(radius: 3)
    }
}

#Preview {

    let context = PersistenceController.shared.container.viewContext

    let memory = MemoryEntity(context: context)

    memory.title = "Beach Sunset"
    memory.note = "Watched the sunset at Baga Beach."
    memory.rating = 5
    memory.date = Date()

    return MemoryCard(memory: memory)
        .padding()
        .environmentObject(MemoryViewModel())
}
