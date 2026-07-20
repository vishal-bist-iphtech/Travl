//
//  BookingViewModel.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//

import SwiftUI
import Combine

final class BookingViewModel: ObservableObject {
    
    @Published private(set) var bookings: [BookingEntity] = []
    
    private let coreDataService = CoreDataService.shared
    
    
    let bookingTypes = [
        "Flight",
        "Hotel",
        "Train",
        "Bus",
        "Cab",
        "Activity",
        "Restaurent",
        "Other"
    ]
    
    let bookingStatus = [
        "Confirmed",
        "Pending",
        "Cancelled"
    ]
    
    let currencies = [
        "INR",
        "USD",
        "EUR",
        "JPY",
        "GBP",
    ]
    
    init() {
        loadBookings()
    }
    
    private func loadBookings() {
        bookings = coreDataService.fetchBookings()
    }
    
    func addBooking (
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
        
        coreDataService.addBooking(
            title: title,
            bookingType: bookingType,
            provider: provider,
            bookingReference: bookingReference,
            startDate: startDate,
            endDate: endDate ?? Date(),
            amount: amount,
            currency: currency,
            status: status,
            notes: notes
        )
        
        refresh()
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
        
        coreDataService.updateBooking(
            booking: booking,
            title: title,
            bookingType: bookingType,
            provider: provider,
            bookingReference: bookingReference,
            startDate: startDate,
            endDate: endDate,
            amount: amount,
            currency: currency,
            status: status,
            notes: notes
        )
        
        refresh()
    }
    
    func deleteBooking(
        _ booking: BookingEntity
    ) {
        coreDataService.deleteBooking(booking)
        
        refresh()
    }
    
    func refresh() {
        loadBookings()
    }
    
    func bookingIcon(
        booking: BookingEntity
    ) -> String {
   
           switch booking.bookingType {
   
           case "Flight":
               return "airplane"
   
           case "Hotel":
               return "bed.double.fill"
   
           case "Train":
               return "train.side.front.car"
   
           case "Bus":
               return "bus.fill"
   
           case "Cab":
               return "car.fill"
   
           case "Activity":
               return "ticket.fill"
   
           case "Restaurant":
               return "fork.knife"
   
           default:
               return "calendar"
           }
       }
   
       func statusColor(
        booking: BookingEntity
       ) -> Color {
   
           switch booking.status {
   
           case "Confirmed":
               return .green
   
           case "Pending":
               return .orange
   
           case "Cancelled":
               return .red
   
           default:
               return .gray
           }
       }
}
