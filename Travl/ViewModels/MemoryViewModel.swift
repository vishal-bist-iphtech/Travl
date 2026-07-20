//
//  MemoryViewModel.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import SwiftUI
import Combine

final class MemoryViewModel: ObservableObject {
    
    @Published private(set) var memories: [MemoryEntity] = []
    
    private let coreDataService = CoreDataService.shared
    
    init() {
        loadMemories()
    }

    private func loadMemories() {

        memories = coreDataService.fetchMemories()
    }

    func addMemory(
        title: String,
        note: String,
        imageData: Data?,
        rating: Int16,
        date: Date,
        trip: TripEntity?
    ) {

        coreDataService.addMemory(
            title: title,
            note: note,
            imageData: imageData,
            rating: rating,
            date: date,
            trip: trip
        )

        refresh()
    }
    
    func updateMemory(
        _ memory: MemoryEntity,
        title: String,
        note: String,
        imageData: Data?,
        rating: Int16,
        date: Date
    ) {
        
        memory.title = title
        memory.note = note
        memory.imageData = imageData
        memory.rating = rating
        memory.date = date
        
        coreDataService.updateMemory()
        
        refresh()
    }

    func deleteMemory(
        _ memory: MemoryEntity
    ) {

        coreDataService.deleteMemory(memory)

        refresh()
    }
    
    func refresh() {
        loadMemories()
    }
    
    func toggleFavorite(for memory: MemoryEntity) {
        
        memory.isFavorite.toggle()
        
        coreDataService.updateMemory()
        
        refresh()
    }
    
    var recentMemories: [MemoryEntity] {

        memories
            .sorted {
                ($0.date ?? .distantPast) > ($1.date ?? .distantPast)
            }
            .prefix(5)
            .map { $0 }
    }
    
    var favoriteMemories: [MemoryEntity] {

        memories.filter {
            $0.isFavorite
        }
    }   

}
