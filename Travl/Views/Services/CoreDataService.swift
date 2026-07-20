//
//  CoreDataService.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

/*
Since i have many viewModels in this project, therefore i created
this file so that it can act as a middleware between the viewmodels and core data.
 
                            Any ViewModel
                                    │
                                    ▼
                             CoreDataService
                                    │
                                    ▼
                             MemoryEntity
 
*/

import Foundation
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    
    private let context: NSManagedObjectContext
    
    private init(
        context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    ) {
        self.context = context
    }
    
    func saveContext() {
        
        guard context.hasChanges else {return}
        
        do {
            try context.save()
        } catch {
            print("Core Data Save Error: \n\(error.localizedDescription)")
        }
    }
    
   
    // ------------->  MARK: Trip Functions
    func addTrip(
        destination: String,
        country: String,
        city: String,
        startDate: Date,
        endDate: Date,
        budget: Double,
        currency: String,
        status: String
    ) {
        
        let trip = TripEntity(context: context)
        
        trip.id = UUID()
        trip.destination = destination
        trip.country = country
        trip.city = city
        trip.startDate = startDate
        trip.endDate = endDate
        trip.budget = budget
        trip.currency = currency
        trip.status = status
        
        saveContext()
    }
    
    func fetchTrips() -> [TripEntity] {
        
        let request: NSFetchRequest<TripEntity> = TripEntity.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "startDate", ascending: true)
        ]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error While Fetching Trips:\n \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteTrip(_ trip: TripEntity) {
        
        context.delete(trip)
        
        saveContext()
    }
    
    func updateTrip(
        trip: TripEntity,
        destination: String,
        country: String,
        city: String,
        startDate: Date,
        endDate: Date,
        budget: Double,
        currency: String,
        status: String
    ) {

        trip.destination = destination
        trip.country = country
        trip.city = city
        trip.startDate = startDate
        trip.endDate = endDate
        trip.budget = budget
        trip.currency = currency
        trip.status = status

        saveContext()
    }
    
// ---------------------> MARK: Memory Functions
    func fetchMemories() -> [MemoryEntity] {

        let request: NSFetchRequest<MemoryEntity> = MemoryEntity.fetchRequest()

        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]


        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch memories:\n \(error)")
            return []
        }
    }

    func addMemory(
        title: String,
        note: String,
        imageData: Data?,
        rating: Int16,
        date: Date
    ) {

        let memory = MemoryEntity(context: context)

        memory.id = UUID()
        memory.title = title
        memory.note = note
        memory.imageData = imageData
        memory.rating = rating
        memory.date = date

        saveContext()

    }

    func updateMemory() {
        saveContext()
    }

    func deleteMemory(_ memory: MemoryEntity) {

        context.delete(memory)

        saveContext()
    }
    
}
