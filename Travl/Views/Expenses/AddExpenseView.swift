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

  
    var body: some View {

        NavigationStack {

            Form {

                Section("Expense Details") {

                    TextField("Title", text: $title)

                    HStack(spacing: 10){
                        
                        
                       Menu {
                            
                            ForEach(expenseViewModel.currencies, id: \.self) { cur in
                                Button(cur) {
                                    selectedCurrency = cur
                                }
                            }
                       } label: {
                           HStack(spacing: 4) {
                               Text((selectedCurrency))
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

                    Picker("Category", selection: $selectedCategory) {

                        ForEach(expenseViewModel.categories, id: \.self) {
                            Text($0)
                        }
                    }


                    Picker("Payment Method",
                           selection: $selectedPaymentMethod) {

                        ForEach(expenseViewModel.paymentMethods,
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

    trip.title = "Goa"

    return AddExpenseView(trip: trip)
        .environmentObject(ExpenseViewModel())
}
