//
//  BookingForm.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//

import SwiftUI

struct BookingForm: View {

    @EnvironmentObject private var bookingViewModel: BookingViewModel

    @Binding var title: String
    @Binding var bookingType: String
    @Binding var provider: String
    @Binding var bookingReference: String

    @Binding var startDate: Date
    @Binding var endDate: Date

    @Binding var amount: String
    @Binding var currency: String
    @Binding var status: String

    @Binding var notes: String

    var body: some View {
        Form {

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

            Section("Payment") {

                TextField(
                    "Amount",
                    text: $amount
                )
                .keyboardType(.decimalPad)

                Picker(
                    "Currency",
                    selection: $currency
                ) {

                    ForEach(
                        bookingViewModel.currencies,
                        id: \.self
                    ) {
                        Text($0)
                    }
                }
            }

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

            Section("Notes") {

                TextEditor(text: $notes)
                    .frame(height: 120)
            }
        }
    }
}
