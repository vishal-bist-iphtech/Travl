//
//  TripInfoSection.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData

struct TripInfoSection: View {

    @ObservedObject var trip: TripEntity

    var body: some View {

        VStack(spacing: 24) {

            VStack(alignment: .leading, spacing: 8) {

                Text(trip.title ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("\(trip.city ?? ""), \(trip.country ?? "")")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading) {
                
                Text("Trip Information")
                    .font(.title2)
                    .bold()
                    .padding(.bottom,4)

                VStack(spacing: 16) {

                    DetailRow(
                        title: "Start Date",
                        value: trip.startDate?.formatted(
                            date: .abbreviated,
                            time: .omitted
                        ) ?? "-"
                    )

                    DetailRow(
                        title: "End Date",
                        value: trip.endDate?.formatted(
                            date: .abbreviated,
                            time: .omitted
                        ) ?? "-"
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
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(.secondary.opacity(0.1)))
            
            
        }
    }
}


#Preview {
    let context = PersistenceController.preview.container.viewContext

    let trip = TripEntity(context: context)

    trip.title = "Paris"
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
