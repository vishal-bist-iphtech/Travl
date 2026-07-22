////
////  PackingViewModel.swift
////  Travl
////
////  Created by iPHTech 34 on 22/07/26.
////
//
//import SwiftUI
//import CoreData
//import Combine
//
//final class PackingViewModel: ObservableObject {
//    
//    @Published var items: [PackingItemEntity] = []
//    
//    private let coreDataService = CoreDataService.shared
//
//    init() {
//
//        loadItems()
//    }
//
//    func loadItems() {
//
//        items = coreDataService.fetchPackingItems()
//    }
//
//    func refresh() {
//
//        loadItems()
//    }
//
//    func addItem(
//        title: String,
//        category: String,
//        quantity: Int,
//        notes: String,
//        trip: TripEntity?
//    ) {
//
//        let item = PackingItemEntity
//
//        item.id = UUID()
//        item.title = title
//        item.category = category
//        item.quantity = Int16(quantity)
//        item.notes = notes
//        item.isPacked = false
//        item.trip = trip
//
//        coreDataService.saveContext()
//
//        refresh()
//    }
//
//    func updateItem(
//        item: PackingItemEntity,
//        title: String,
//        category: String,
//        quantity: Int,
//        notes: String
//    ) {
//
//        item.title = title
//        item.category = category
//        item.quantity = Int16(quantity)
//        item.notes = notes
//
//        CoreDataService.shared.saveContext()
//
//        refresh()
//    }
//
//    func deleteItem(_ item: PackingItemEntity) {
//
////        coreDataService.delete(item)
////
////        coreDataService.saveContext()
//
//        refresh()
//    }
//
//    func togglePacked(_ item: PackingItemEntity) {
//
//        item.isPacked.toggle()
//
//        CoreDataService.shared.saveContext()
//
//        refresh()
//    }
//
//    func items(for trip: TripEntity) -> [PackingItemEntity] {
//
//        items.filter { $0.trip == trip }
//    }
//
//    func progress(for trip: TripEntity) -> Double {
//
//        let items = items(for: trip)
//
//        guard !items.isEmpty else { return 0 }
//
//        return Double(
//            packedCount(for: trip)
//        ) / Double(items.count)
//    }
//
//    func packedCount(for trip: TripEntity) -> Int {
//
//        items(for: trip)
//            .filter(\.isPacked)
//            .count
//    }
//
//    func remainingCount(for trip: TripEntity) -> Int {
//
//        items(for: trip)
//            .filter { !$0.isPacked }
//            .count
//    }
//}
