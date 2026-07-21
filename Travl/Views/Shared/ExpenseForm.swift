//
//  ExpenseForm.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI

struct ExpenseForm: View {

    @Binding var title: String

    @Binding var amount: String

    @Binding var category: String

    @Binding var paymentMethod: String

    @Binding var currency: String

    @Binding var date: Date

    @Binding var notes: String

    private let categories = [
        "Food",
        "Transport",
        "Hotel",
        "Flight",
        "Shopping",
        "Activity",
        "Other"
    ]

    private let paymentMethods = [
        "Cash",
        "Credit Card",
        "Debit Card",
        "UPI",
        "Wallet"
    ]

    private let currencies = [
        "INR",
        "USD",
        "EUR",
        "GBP"
    ]

    var body: some View {

        Form {

            Section("Expense") {

                TextField(
                    "Title",
                    text: $title
                )

                TextField(
                    "Amount",
                    text: $amount
                )
                .keyboardType(.decimalPad)

                Picker(
                    "Category",
                    selection: $category
                ) {

                    ForEach(categories, id: \.self) {

                        Text($0)
                    }
                }

                Picker(
                    "Payment",
                    selection: $paymentMethod
                ) {

                    ForEach(paymentMethods, id: \.self) {

                        Text($0)
                    }
                }

                Picker(
                    "Currency",
                    selection: $currency
                ) {

                    ForEach(currencies, id: \.self) {

                        Text($0)
                    }
                }

                DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: .date
                )
            }

            Section("Notes") {

                TextEditor(text: $notes)
                    .frame(height: 120)
            }
        }
    }
}
