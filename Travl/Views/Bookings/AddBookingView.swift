//
//  AddBookingView.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//

import SwiftUI

struct AddBookingView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var bookingViewModel: BookingViewModel
    
    let trip: TripEntity?

    @State private var title = ""
    @State private var bookingType = "Flight"
    @State private var provider = ""
    @State private var bookingReference = ""

    @State private var startDate = Date()
    @State private var endDate = Date()

    @State private var amount = ""
    @State private var currency = "INR"

    @State private var status = "Confirmed"

    @State private var notes = ""

    var body: some View {

        NavigationStack {

            Form {

                // MARK: Booking

                Section("Booking") {

                    TextField("Title", text: $title)

                    Picker("Booking Type", selection: $bookingType) {

                        ForEach(bookingViewModel.bookingTypes, id: \.self) {
                            Text($0)
                        }
                    }

                    TextField("Provider", text: $provider)

                    TextField(
                        "Booking Reference",
                        text: $bookingReference
                    )
                }

                // MARK: Schedule

                Section("Schedule") {

                    DatePicker(
                        "Start Date",
                        selection: $startDate,
                        displayedComponents: .date
                    )

                    DatePicker(
                        "End Date",
                        selection: $endDate,
                        displayedComponents: .date
                    )
                }

                // MARK: Payment

                Section("Payment") {

                    HStack(spacing: 10){
                        
                        
                       Menu {
                            
                            ForEach(bookingViewModel.currencies, id: \.self) { cur in
                                Button(cur) {
                                    currency = cur
                                }
                            }
                       } label: {
                           HStack(spacing: 4) {
                               Text((currency))
                               Image(systemName: "chevron.down")
                                   .font(.caption2)
                           }
                           .frame(width: 60)
                       }
                        Divider()
                            .background(Color.primary)
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 18))
                            .padding(.horizontal)
                    }
                }

                // MARK: Status

                Section("Status") {

                    Picker(
                        "Status",
                        selection: $status
                    ) {

                        ForEach(
                            bookingViewModel.bookingStatus,
                            id: \.self
                        ) {
                            Text($0)
                        }
                    }
                }

                // MARK: Notes

                Section("Notes") {

                    TextEditor(text: $notes)
                        .frame(height: 120)
                }
            }
            .navigationTitle("New Booking")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Save") {

                        bookingViewModel.addBooking(
                            title: title,
                            bookingType: bookingType,
                            provider: provider,
                            bookingReference: bookingReference,
                            startDate: startDate,
                            endDate: endDate,
                            amount: Double(amount) ?? 0,
                            currency: currency,
                            status: status,
                            notes: notes,
                            trip: trip
                        )

                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }
            }
        }
    }
}

#Preview {

    NavigationStack {

        AddBookingView(trip: nil)
    }
    .environmentObject(BookingViewModel())
}
