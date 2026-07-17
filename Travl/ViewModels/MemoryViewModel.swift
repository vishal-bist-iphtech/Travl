//
//  MemoryViewModel.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import SwiftUI
import Combine

final class MemoryViewModel: ObservableObject {

    @Published var memories: [MemoryEntity] = []

    private let coreDataService = CoreDataService.shared

    func loadMemories(for trip: TripEntity) {

        memories = coreDataService.fetchMemories(for: trip)
    }

    func addMemory(
        title: String,
        note: String,
        imageData: Data?,
        rating: Int16,
        date: Date,
        trip: TripEntity
    ) {

        coreDataService.addMemory(
            title: title,
            note: note,
            imageData: imageData,
            rating: rating,
            date: date,
            trip: trip
        )

        loadMemories(for: trip)
    }

    func deleteMemory(
        _ memory: MemoryEntity,
        trip: TripEntity
    ) {

        coreDataService.deleteMemory(memory)

        loadMemories(for: trip)
    }

    func refresh(for trip: TripEntity) {

        loadMemories(for: trip)
    }
}
