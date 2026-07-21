//
//  ExpenseDetailView.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData

struct ExpenseDetailView: View {

    @EnvironmentObject private var expenseViewModel: ExpenseViewModel
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var expense: ExpenseEntity


    @State private var showDeleteAlert = false

    var body: some View {

        List {

            Section("Expense") {

                DetailRow(
                    title: "Title",
                    value: expense.title ?? "-"
                )

                DetailRow(
                    title: "Amount",
                    value: "\(expense.currency ?? "") \(expense.amount)"
                )

                DetailRow(
                    title: "Category",
                    value: expense.category ?? "-"
                )

                DetailRow(
                    title: "Payment",
                    value: expense.paymentMethod ?? "-"
                )

                DetailRow(
                    title: "Date",
                    value: expense.date?.formatted(
                        date: .abbreviated,
                        time: .omitted
                    ) ?? "-"
                )
            }

            if let notes = expense.notes,
               !notes.isEmpty {

                Section("Notes") {
                    Text(notes)
                }
            }
        }
        .navigationTitle("Expense")
        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                NavigationLink {

                    EditExpenseView(expense: expense)
                        .environmentObject(expenseViewModel)

                } label: {

                    Image(systemName: "square.and.pencil")
                }

                Button(role: .destructive) {

                    showDeleteAlert = true

                } label: {

                    Image(systemName: "trash")
                }
            }
        }
        .alert("Delete Expense?",
               isPresented: $showDeleteAlert) {

            Button("Delete", role: .destructive) {

                expenseViewModel.deleteExpense(expense)

                dismiss()
            }

            Button("Cancel", role: .cancel) { }

        } message: {

            Text("This action cannot be undone.")
        }
    }
}


#Preview {

    let context = PersistenceController.preview.container.viewContext

    let expense = ExpenseEntity(context: context)

    expense.title = "Dinner"
    expense.amount = 850
    expense.currency = "INR"
    expense.category = "Food"
    expense.paymentMethod = "Cash"
    expense.date = .now
    expense.notes = "Pizza"

    return NavigationStack {

        ExpenseDetailView(expense: expense)
    }
    .environmentObject(ExpenseViewModel())
}
