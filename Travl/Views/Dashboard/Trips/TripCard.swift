//
//  TripCard.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI
import CoreData

struct TripCard: View {
    
    @ObservedObject var trip: TripEntity

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

                    // Destination & Status
                    HStack {

                        VStack(alignment: .leading, spacing: 4) {

                            Text(trip.destination ?? "Unknown Destination")
                                .font(.title3)
                                .fontWeight(.bold)

                            Text("\(trip.city ?? "") \(trip.country ?? "")")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text(trip.status ?? "Unknown")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(statusColor.opacity(0.15))
                            .foregroundColor(statusColor)
                            .clipShape(Capsule())
                    }

                    Divider()

                    // Dates & Budget
                    HStack {

                        VStack(alignment: .leading, spacing: 6) {

                            Label {
                                Text(dateRange)
                            } icon: {
                                Image(systemName: "calendar")
                            }

                            Label {
                                Text("\(trip.currency ?? "") \(Int(trip.budget))")
                            } icon: {
                                Image(systemName: "indianrupeesign.circle")
                            }
                        }

                        Spacer()
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }

            // MARK: - Helpers

            private var dateRange: String {

                guard
                    let start = trip.startDate,
                    let end = trip.endDate
                else {
                    return "No Dates"
                }

                return "\(start.formatted(date: .abbreviated, time: .omitted)) - \(end.formatted(date: .abbreviated, time: .omitted))"
            }

            private var statusColor: Color {

                switch trip.status {

                case "Upcoming":
                    return .blue

                case "Ongoing":
                    return .green

                case "Completed":
                    return .gray

                default:
                    return .orange
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
        trip.budget = 120000
        trip.status = "Upcoming"
        trip.startDate = Date()
        trip.endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())

        return TripCard(trip: trip)
            .padding()
}
