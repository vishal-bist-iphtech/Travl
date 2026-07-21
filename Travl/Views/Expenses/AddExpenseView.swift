//
//  AddExpenseView.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData

struct AddExpenseView: View {

    let trip: TripEntity?

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var expenseViewModel: ExpenseViewModel

    @State private var title = ""
    @State private var amount = ""
    @State private var selectedCategory = "Food"
    @State private var selectedPaymentMethod = "Cash"
    @State private var selectedCurrency = "INR"
    @State private var date = Date()
    @State private var notes = ""

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

    var body: some View {

        NavigationStack {

            Form {

                Section("Expense Details") {

                    TextField("Title", text: $title)

                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)

                    Picker("Category", selection: $selectedCategory) {

                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }

                    Picker("Currency", selection: $selectedCurrency) {

                        Text("INR").tag("INR")
                        Text("USD").tag("USD")
                        Text("EUR").tag("EUR")
                        Text("GBP").tag("GBP")
                    }

                    Picker("Payment Method",
                           selection: $selectedPaymentMethod) {

                        ForEach(paymentMethods,
                                id: \.self) {

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
                        .frame(minHeight: 120)
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("Cancel") {

                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Save") {

                        expenseViewModel.addExpense(
                            title: title,
                            amount: Double(amount) ?? 0,
                            category: selectedCategory,
                            date: date,
                            notes: notes,
                            paymentMethod: selectedPaymentMethod,
                            currency: selectedCurrency,
                            trip: trip
                        )

                        dismiss()
                    }
                    .disabled(title.isEmpty || amount.isEmpty)
                }
            }
        }
    }
}


#Preview {

    let context = PersistenceController.preview.container.viewContext

    let trip = TripEntity(context: context)

    trip.destination = "Goa"

    return AddExpenseView(trip: trip)
        .environmentObject(ExpenseViewModel())
}
