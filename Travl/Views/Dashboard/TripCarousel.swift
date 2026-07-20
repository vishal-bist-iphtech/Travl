//
//  TripCarousel.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI
import CoreData

struct TripCarousel: View {
    
    let trips: [TripEntity]
    
    @EnvironmentObject private var tripViewModel: TripViewModel
    
    @State private var showAddTrip = false

    var body: some View {

        VStack(alignment:.leading){

            HStack {

                Text("All Trips")
                    .font(.title3)
                    .fontWeight(.bold)

                Spacer()

                if trips.isEmpty {

                    Button("Add Trip") {
                        showAddTrip = true
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)

                } else {

                    NavigationLink("See More") {
                        TripsView()
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showAddTrip) {

                AddTripView()
                    .environmentObject(tripViewModel)
            }

            if trips.isEmpty {

                ContentUnavailableView(
                    "No Trips",
                    systemImage: "airplane.departure",
                    description: Text("Add your first trip here.")
                )

            } else {

                ScrollView(.horizontal, showsIndicators: false) {

                    HStack(spacing: 16) {

                        ForEach(trips, id: \.objectID) { trip in

                            NavigationLink {

                                TripDetailView(
                                    trip: trip
                                )

                            } label: {

                                TripCard(trip: trip)
                                    .frame(width: 320)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }
}



#Preview {

    let context = PersistenceController.preview.container.viewContext

    let trip = TripEntity(context: context)

    trip.destination = "Paris"
    trip.city = "Paris"
    trip.country = "France"
    trip.currency = "INR"
    trip.budget = 120000
    trip.status = "Upcoming"
    trip.startDate = Date()
    trip.endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())

    return TripCarousel(
        trips: [trip],
    )
    .padding()
    .environmentObject(
        TripViewModel()
    )
}
