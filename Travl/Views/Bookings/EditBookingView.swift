//
//  EditBookingView.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//

import SwiftUI
import CoreData

struct EditBookingView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var bookingViewModel: BookingViewModel

    let booking: BookingEntity

    @State private var title: String
    @State private var provider: String
    @State private var bookingReference: String

    @State private var bookingType: String
    @State private var status: String
    @State private var currency: String

    @State private var startDate: Date
    @State private var endDate: Date

    @State private var amount: String
    @State private var notes: String

    init(booking: BookingEntity) {

        self.booking = booking

        _title = State(initialValue: booking.title ?? "")
        _provider = State(initialValue: booking.provider ?? "")
        _bookingReference = State(initialValue: booking.bookingReference ?? "")

        _bookingType = State(initialValue: booking.bookingType ?? "Flight")
        _status = State(initialValue: booking.status ?? "Confirmed")
        _currency = State(initialValue: booking.currency ?? "INR")

        _startDate = State(initialValue: booking.startDate ?? .now)
        _endDate = State(initialValue: booking.endDate ?? .now)

        _amount = State(initialValue: "\(booking.amount)")
        _notes = State(initialValue: booking.notes ?? "")
    }

    var body: some View {

        NavigationStack {

            BookingForm(
                    title: $title,
                    bookingType: $bookingType,
                    provider: $provider,
                    bookingReference: $bookingReference,
                    startDate: $startDate,
                    endDate: $endDate,
                    amount: $amount,
                    currency: $currency,
                    status: $status,
                    notes: $notes
                )
                .navigationTitle("Edit Booking")
                .navigationBarTitleDisplayMode(.inline)

                .toolbar {

//                    ToolbarItem(placement: .topBarLeading) {
//
//                        Button("Cancel") {
//                            dismiss()
//                        }
//                    }

                    ToolbarItem(placement: .topBarTrailing) {

                        Button("Save") {

                            bookingViewModel.updateBooking(
                                booking: booking,
                                title: title,
                                bookingType: bookingType,
                                provider: provider,
                                bookingReference: bookingReference,
                                startDate: startDate,
                                endDate: endDate,
                                amount: Double(amount) ?? 0,
                                currency: currency,
                                status: status,
                                notes: notes
                            )

                            dismiss()
                        }
                        .fontWeight(.semibold)
                }
            }
        }
    }
}


#Preview {

    let context = PersistenceController.preview.container.viewContext

    let booking = BookingEntity(context: context)

    booking.id = UUID()
    booking.title = "Delhi to Goa"
    booking.bookingType = "Flight"
    booking.provider = "IndiGo"
    booking.bookingReference = "6E8452"
    booking.startDate = .now
    booking.endDate = Calendar.current.date(byAdding: .day, value: 5, to: .now)
    booking.amount = 7499
    booking.currency = "INR"
    booking.status = "Confirmed"
    booking.notes = "Window seat preferred."

    return EditBookingView(
        booking: booking
    )
    .environmentObject(BookingViewModel())
}
