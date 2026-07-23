//
//  SelectBookingView.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//

import SwiftUI
import CoreData

struct SelectBookingView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var bookingViewModel: BookingViewModel

    let trip: TripEntity

    private var availableBookings: [BookingEntity] {

        bookingViewModel.bookings
            .filter { $0.trip == nil }
            .sorted {
                ($0.startDate ?? .distantFuture) <
                ($1.startDate ?? .distantFuture)
            }
    }

    var body: some View {

        Group {

            if availableBookings.isEmpty {

                ContentUnavailableView(
                    "No Available Bookings",
                    systemImage: "ticket",
                    description: Text("Create a new booking or remove one from another trip.")
                )

            } else {

                ScrollView {

                    LazyVStack(spacing: 16) {

                        ForEach(availableBookings, id: \.objectID) { booking in

                            Button {

                                attach(booking)

                            } label: {

                                BookingCard(booking: booking)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Add Existing Booking")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func attach(_ booking: BookingEntity) {

        booking.trip = trip

        CoreDataService.shared.saveContext()

        bookingViewModel.refresh()

        dismiss()
    }
}

#Preview {

    let context = PersistenceController.preview.container.viewContext

    let trip = TripEntity(context: context)
    trip.title = "Goa"

    let booking = BookingEntity(context: context)
    booking.title = "Hotel Booking"
    booking.bookingType = "Hotel"
    booking.provider = "Booking.com"
    booking.bookingReference = "ABC123"
    booking.status = "Confirmed"
    booking.amount = 5000
    booking.startDate = .now
    booking.endDate = Calendar.current.date(byAdding: .day, value: 2, to: .now)
    booking.trip = nil

    return NavigationStack {

        SelectBookingView(trip: trip)
    }
    .environmentObject(BookingViewModel())
}
