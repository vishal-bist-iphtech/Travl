//
//  TestView.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import SwiftUI

struct TestView: View {

    @StateObject private var tripViewModel = TripViewModel()

    var body: some View {

        NavigationStack {

            VStack {

                Button("Add Sample Trip") {

                    tripViewModel.addTrip(
                        destination: "Paris",
                        country: "France",
                        city: "Paris",
                        startDate: Date(),
                        endDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                        budget: 150000,
                        currency: "INR",
                        status: "Upcoming"
                    )
                }
                .buttonStyle(.borderedProminent)
                .padding()

                List {

                    ForEach(tripViewModel.trips, id: \.objectID) { trip in

                        VStack(alignment: .leading, spacing: 5) {

                            Text(trip.destination ?? "Unknown")
                                .font(.headline)

                            Text("\(trip.city ?? ""), \(trip.country ?? "")")

                            Text("Budget: \(trip.currency ?? "") \(trip.budget)")
                        }
                    }
                    .onDelete { indexSet in

                        indexSet.forEach { index in
                            tripViewModel.deleteTrip(
                                tripViewModel.trips[index]
                            )
                        }
                    }
                }
            }
            .navigationTitle("Trip Test")
        }
    }
}

#Preview {
    TestView()
}
