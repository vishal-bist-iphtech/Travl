//
//  TripDetailView.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import SwiftUI
import CoreData

struct TripDetailView: View {

    let trip: TripEntity

    @EnvironmentObject private var tripViewModel: TripViewModel

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                // MARK: Header

                VStack(alignment: .leading, spacing: 8) {

                    Text(trip.destination ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("\(trip.city ?? ""), \(trip.country ?? "")")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // MARK: Trip Information

                GroupBox("Trip Information") {

                    VStack(spacing: 16) {

                        DetailRow(
                            title: "Start Date",
                            value: trip.startDate?.formatted(date: .abbreviated, time: .omitted) ?? "-"
                        )

                        DetailRow(
                            title: "End Date",
                            value: trip.endDate?.formatted(date: .abbreviated, time: .omitted) ?? "-"
                        )

                        DetailRow(
                            title: "Budget",
                            value: "\(trip.currency ?? "") \(Int(trip.budget))"
                        )

                        DetailRow(
                            title: "Status",
                            value: trip.status ?? "-"
                        )
                    }
                }

                // MARK: Modules

                VStack(spacing: 12) {

                    NavigationLink("Itinerary") {
                        Text("Itinerary")
                    }

                    NavigationLink("Expenses") {
                        Text("Expenses")
                    }

                    NavigationLink("Bookings") {
                        Text("Bookings")
                    }

                    NavigationLink("Packing List") {
                        Text("Packing List")
                    }

                    NavigationLink("Memories") {
                        Text("Memories")
                    }

                    NavigationLink("Weather") {
                        Text("Weather")
                    }

                    NavigationLink("Map") {
                        Text("Map")
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)

            }
            .padding()
        }
        .navigationTitle("Trip")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {

                NavigationLink {

                    EditTripView(
                        trip: trip
                    )

                } label: {

                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
}

#Preview {

    let context = PersistenceController.shared.container.viewContext

    let trip = TripEntity(context: context)

    trip.destination = "Paris"
    trip.city = "Paris"
    trip.country = "France"
    trip.currency = "INR"
    trip.budget = 100000
    trip.status = "Upcoming"
    trip.startDate = Date()
    trip.endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())

    return NavigationStack {

        TripDetailView(
            trip: trip
        )
    }
    .environmentObject(
        TripViewModel()
    )
}
