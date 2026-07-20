//
//  DashboardView.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject private var tripViewModel: TripViewModel
    @EnvironmentObject private var memoryViewModel: MemoryViewModel
    
    private var upcomingTrips: [TripEntity] {

        tripViewModel.trips
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
    
    private var nextTrip: TripEntity? {

        upcomingTrips.first
    }
    
    private var totalBudget: Double {

        upcomingTrips.reduce(0) { $0 + $1.budget }
    }
    
    private var daysRemaining: Int? {

        guard
            let trip = nextTrip,
            let startDate = trip.startDate
        else {
            return nil
        }

        return Calendar.current.dateComponents(
            [.day],
            from: Calendar.current.startOfDay(for: Date()),
            to: Calendar.current.startOfDay(for: startDate)
        ).day
    }

    
    var body: some View {
        
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HeaderView()
                    
                    NextTripCard(
                        trip: nextTrip,
                        daysRemaining:daysRemaining
                    )
                    
                    HStack(spacing: 16) {
                        BudgetCard(
                            totalBudget: totalBudget
                        )
                        DaysCard(
                            daysRemaining: daysRemaining
                        )
                    }
                    
                    PackingProgressCard()
                    
                    TripCarousel(
                        trips: tripViewModel.trips
                    )
                    MemoryCarousel(
                        memories: memoryViewModel.memories
                    )
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(TripViewModel())
        .environmentObject(MemoryViewModel())
}
