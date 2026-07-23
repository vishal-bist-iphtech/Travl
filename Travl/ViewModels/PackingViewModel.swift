//
//  PackingViewModel.swift
//  Travl
//
//  Created by iPHTech 34 on 22/07/26.
//

import SwiftUI
import CoreData
import Combine

final class PackingViewModel: ObservableObject {
    
    @Published private(set) var packingItems: [PackingItemEntity] = []
    
    private let coreDataService = CoreDataService.shared
    
    init() {
        loadPackingItems()
    }
    
    // MARK: - Categories
    
    let categories = [
        "Clothes",
        "Documents",
        "Electronics",
        "Toiletries",
        "Medicines",
        "Accessories",
        "Food",
        "Others"
    ]
    
    // MARK: - Data
    
    private func loadPackingItems() {
        packingItems = coreDataService.fetchPackingItems()
    }
    
    func refresh() {
        loadPackingItems()
    }
    
    func addPackingItem(
        title: String,
        category: String,
        quantity: Int,
        notes: String,
        trip: TripEntity?
    ) {
        
        coreDataService.addPackingItem(
            title: title,
            category: category,
            quantity: quantity,
            notes: notes,
            trip: trip
        )
        
        refresh()
    }
    
    
    func updatePackingItem(
        item: PackingItemEntity,
        title: String,
        category: String,
        quantity: Int,
        notes: String,
        isPacked: Bool
    ) {
        
        coreDataService.updatePackingItem(
            item: item,
            title: title,
            category: category,
            quantity: quantity,
            notes: notes,
            isPacked: isPacked
        )
        
        refresh()
    }
    
    
    func deletePackingItem(_ item: PackingItemEntity) {
        
        coreDataService.deletePackingItem(item)
        
        refresh()
    }
    
    
    func togglePacked(_ item: PackingItemEntity) {
        
        item.isPacked.toggle()
        
        coreDataService.saveContext()
        
        refresh()
    }
    
    
    func items(for trip: TripEntity) -> [PackingItemEntity] {
        
        packingItems
            .filter { $0.trip == trip }
    }
    
    func progress(for trip: TripEntity) -> Double {
        
        let items = items(for: trip)
        
        guard !items.isEmpty else { return 0 }
        
        return Double(
            packedCount(for: trip)
        ) / Double(items.count)
    }
    
    func packedCount(for trip: TripEntity) -> Int {
        
        items(for: trip)
            .filter(\.isPacked)
            .count
    }
    
    func remainingCount(for trip: TripEntity) -> Int {
        
        items(for: trip)
            .filter { !$0.isPacked }
            .count
    }
    
    func recentItems(for trip: TripEntity) -> [PackingItemEntity] {
        
        items(for: trip)
            .sorted {
                ($0.title ?? "") < ($1.title ?? "")
            }
            .prefix(5)
            .map { $0 }
    }
    
    func categoryCount(for trip: TripEntity) -> Int {
        
        Set(
            items(for: trip)
                .compactMap(\.category)
        ).count
    }
    
    func categoryBreakdown(for trip: TripEntity) -> [(String, Int)] {

        Dictionary(
            grouping: items(for: trip),
            by: { $0.category ?? "Others" }
        )
        .map { ($0.key, $0.value.count) }
        .sorted { $0.1 > $1.1 }
    }
    
    
    func categoryBreakdown(for trip: TripEntity) -> [PackingCategory] {

        let items = self.items(for: trip)

        var counts: [String: Int] = [:]

        for item in items {

            let category = item.category ?? "Others"

            counts[category, default: 0] += 1
        }

        return counts.map {

            PackingCategory(
                name: $0.key,
                count: $0.value
            )

        }
        .sorted { $0.count > $1.count }
    }

}
