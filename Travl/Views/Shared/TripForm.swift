//
//  TripForm.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI

struct TripForm: View {

    @Binding var destination: String
    @Binding var country: String
    @Binding var city: String

    @Binding var startDate: Date
    @Binding var endDate: Date

    @Binding var budget: String
    @Binding var currency: String
    @Binding var status: String

    private let currencies = [
        "INR",
        "USD",
        "EUR",
        "GBP"
    ]

    private let statuses = [
        "Upcoming",
        "Ongoing",
        "Completed"
    ]

    var body: some View {

        Form {

            Section("Destination") {

                TextField("Destination", text: $destination)

                TextField("Country", text: $country)

                TextField("City", text: $city)
            }

            Section("Travel Dates") {

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

            Section("Budget") {

                TextField("Budget", text: $budget)
                    .keyboardType(.decimalPad)

                Picker("Currency", selection: $currency) {

                    ForEach(currencies, id: \.self) {
                        Text($0)
                    }
                }

                Picker("Status", selection: $status) {

                    ForEach(statuses, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    }
}
