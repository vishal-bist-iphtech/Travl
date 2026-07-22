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
    
    
    
// --------------->     MARK: Memory Functions
    
    
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
        date: Date,
        trip: TripEntity?
    ) {

        let memory = MemoryEntity(context: context)

        memory.id = UUID()
        memory.title = title
        memory.note = note
        memory.imageData = imageData
        memory.rating = rating
        memory.date = date
        print("Trip parameter:", trip?.destination ?? "nil")
        
        memory.trip = trip

        print("Assigned trip:", memory.trip?.destination ?? "nil")

        saveContext()

    }

    func updateMemory() {
        saveContext()
    }

    func deleteMemory(_ memory: MemoryEntity) {

        context.delete(memory)

        saveContext()
    }
    
    
// --------------->     MARK: Booking Functions
    
    
    func fetchBookings() -> [BookingEntity] {
        
        let request: NSFetchRequest<BookingEntity> = BookingEntity.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "startDate", ascending: true)
        ]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error while fetching bookings: \n\(error.localizedDescription)")
            return []
        }
    }
    
    func addBooking(
        title: String,
        bookingType: String,
        provider: String,
        bookingReference: String,
        startDate: Date,
        endDate: Date,
        amount: Double,
        currency: String,
        status: String,
        notes: String,
        trip: TripEntity?
    ) {
        
        let booking = BookingEntity(context: context)
        
        booking.id = UUID()
        booking.title = title
        booking.bookingType = bookingType
        booking.provider = provider
        booking.bookingReference = bookingReference
        booking.startDate = startDate
        booking.endDate = endDate
        booking.amount = amount
        booking.currency = currency
        booking.status = status
        booking.notes = notes
        booking.createdAt = Date()
        booking.trip = trip
        
        
        saveContext()
        
    }
    
    func updateBooking(
        booking: BookingEntity,
        title: String,
        bookingType: String,
        provider: String,
        bookingReference: String,
        startDate: Date,
        endDate: Date?,
        amount: Double,
        currency: String,
        status: String,
        notes: String
    ) {
        
        booking.title = title
        booking.bookingType = bookingType
        booking.provider = provider
        booking.bookingReference = bookingReference
        booking.startDate = startDate
        booking.endDate = endDate
        booking.amount = amount
        booking.currency = currency
        booking.status = status
        booking.notes = notes
        
        saveContext()
        
    }
    
    func deleteBooking(_ booking: BookingEntity) {
        
        context.delete(booking)
        
        saveContext()
    }
    
    
    
// --------------->     MARK: Expenses Functions
    
    
    func fetchExpenses() -> [ExpenseEntity] {
        let request: NSFetchRequest<ExpenseEntity> = ExpenseEntity.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error while fetching expenses.\n\(error.localizedDescription)")
            return []
        }
    }
    
    func addExpense(
        title: String,
        amount: Double,
        category: String,
        date: Date,
        notes: String,
        paymentMethod: String,
        currency: String,
        trip: TripEntity?
    ) {
        let expense = ExpenseEntity(context: context)
        
        expense.id = UUID()
        expense.title = title
        expense.amount = amount
        expense.category = category
        expense.date = date
        expense.notes = notes
        expense.paymentMethod = paymentMethod
        expense.currency = currency
        expense.trip = trip
        
        saveContext()
    }
   
    func updateExpense(
        expense: ExpenseEntity,
        title: String,
        amount: Double,
        category: String,
        date: Date,
        notes: String,
        paymentMethod: String,
        currency: String
    ) {

        expense.title = title
        expense.amount = amount
        expense.category = category
        expense.date = date
        expense.notes = notes
        expense.paymentMethod = paymentMethod
        expense.currency = currency

        saveContext()
    }
    
    func deleteExpense(_ expense: ExpenseEntity) {

        context.delete(expense)

        saveContext()
    }
    
    
// -------------->      MARK: Packings Functions
    

//    func fetchPackingItems() -> [PackingItemEntity] {
//
//        let request = PackingItemEntity.fetchRequest()
//
//        request.sortDescriptors = [
//            NSSortDescriptor(keyPath: \PackingItemEntity.isPacked, ascending: true)
//        ]
//
//        do {
//
//            return try context.fetch(request)
//
//        } catch {
//
//            print(error.localizedDescription)
//            return []
//        }
//    }
//    
}
