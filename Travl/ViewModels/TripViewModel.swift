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
        
        refresh()
    }
    
    func deleteTrip(_ trip: TripEntity) {
        
        coreDataService.deleteTrip(trip)
        
        refresh()
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

        refresh()
    }
    
    func refresh() {
        loadTrips()
        
        print(trips.first?.destination ?? "No Trip")
    }
    
    // MARK: - Upcoming Trips

    var upcomingTrips: [TripEntity] {

        trips
            .filter {

                guard let startDate = $0.startDate else {
                    return false
                }

                return startDate >= Calendar.current.startOfDay(for: Date())
            }
            .sorted {

                ($0.startDate ?? .distantFuture) <
                ($1.startDate ?? .distantFuture)
            }
    }

    var nextTrip: TripEntity? {

        upcomingTrips.first
        
    }
    
    
}
