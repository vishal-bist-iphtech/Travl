//
//  BookingCard.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//


import SwiftUI
import CoreData


struct BookingCard: View {
    
    @ObservedObject var booking: BookingEntity
    @EnvironmentObject private var bookingViewModel: BookingViewModel
    
    
    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                HStack(spacing: 10) {

                    Image(systemName: bookingViewModel.bookingIcon(booking: booking))
                        .font(.title3)
                        .foregroundStyle(.blue)
                        .frame(width: 42, height: 42)
                        .background(Color.blue.opacity(0.12))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {

                        Text(booking.bookingType ?? "")
                            .font(.headline)

                        Text(booking.provider ?? "")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                Text(booking.status ?? "")
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(bookingViewModel.statusColor(booking: booking).opacity(0.15))
                    .foregroundStyle(bookingViewModel.statusColor(booking: booking))
                    .clipShape(Capsule())
            }

            Divider()

            // MARK: Title

            Text(booking.title ?? "")
                .font(.title3.bold())

            // MARK: Booking Reference

            HStack {

                Image(systemName: "number")

                Text(booking.bookingReference ?? "-")
                    .foregroundStyle(.secondary)
            }
            .font(.subheadline)

            // MARK: Dates

            HStack {

                Image(systemName: "calendar")

                Text(formattedDateRange)

                Spacer()

                Text("\(booking.currency ?? "") \(booking.amount, specifier: "%.0f")")
                    .fontWeight(.bold)
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
    }
    
    private var formattedDateRange: String {

        guard let startDate = booking.startDate else {
            return "-"
        }

        if let endDate = booking.endDate {

            return "\(startDate.formatted(date: .abbreviated, time: .omitted)) - \(endDate.formatted(date: .abbreviated, time: .omitted))"

        } else {

            return startDate.formatted(date: .abbreviated, time: .omitted)
        }
    }
}

#Preview {
    
    let context = PersistenceController.shared.container.viewContext
    
    let booking = BookingEntity(context: context)
    
    booking.title = "Hotel booking"
    booking.bookingType = "Hotel"
    booking.bookingReference = "Sky hilton"
    booking.status = "Confirmed"
    booking.amount = 3000
    booking.notes = "Check in at 10am"
    booking.provider = "Booking.com"
    booking.startDate = Date()
    booking.endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())
    booking.currency = "INR"
    
    return BookingCard(
        booking: booking
    )
    .padding()
}
