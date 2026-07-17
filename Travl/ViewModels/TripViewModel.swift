//
//  TripViewModel.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import Combine
import CoreData


final class TripViewModel: ObservableObject {
    
    @Published private(set) var trips: [TripEntity] = []
    
    private let coreDataService = CoreDataService.shared
    
    
    init() {
        loadTrips()
    }
    
    
    let statuses = [
        "Upcoming",
        "Ongoing",
        "Completed"
    ]
    
    let currencies = [
        "INR",
        "USD",
        "EUR",
        "JPY",
        "GBP",
    ]
    
    
    
    
    
    // MARK: Functions
    
    private func loadTrips() {
        trips = coreDataService.fetchTrips()
    }
    
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
        coreDataService.addTrip(
            destination: destination,
            country: country,
            city: city,
            startDate: startDate,
            endDate: endDate,
            budget: budget,
            currency: currency,
            status: status
            )
        
        loadTrips()
    }
    
    func deleteTrip(_ trip: TripEntity) {
        
        coreDataService.deleteTrip(trip)
        
        loadTrips()
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

        coreDataService.updateTrip(
            trip: trip,
            destination: destination,
            country: country,
            city: city,
            startDate: startDate,
            endDate: endDate,
            budget: budget,
            currency: currency,
            status: status
        )

        loadTrips()
    }
    
    func refresh() {
        loadTrips()
    }
    
    
}
