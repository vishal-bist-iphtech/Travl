//
//  EditExpenseView.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData

struct EditExpenseView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var expenseViewModel: ExpenseViewModel

    let expense: ExpenseEntity

    @State private var title: String
    @State private var amount: String
    @State private var category: String
    @State private var paymentMethod: String
    @State private var currency: String
    @State private var date: Date
    @State private var notes: String

    init(expense: ExpenseEntity) {

        self.expense = expense

        _title = State(initialValue: expense.title ?? "")
        _amount = State(initialValue: "\(expense.amount)")
        _category = State(initialValue: expense.category ?? "Food")
        _paymentMethod = State(initialValue: expense.paymentMethod ?? "Cash")
        _currency = State(initialValue: expense.currency ?? "INR")
        _date = State(initialValue: expense.date ?? .now)
        _notes = State(initialValue: expense.notes ?? "")
    }

    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Expense Details") {
                    
                    TextField("Title", text: $title)
                    
                    HStack(spacing: 10){
                        
                        
                        Menu {
                            
                            ForEach(expenseViewModel.currencies, id: \.self) { cur in
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
                    
                    Picker("Category", selection: $category) {
                        
                        ForEach(expenseViewModel.categories, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    
                    Picker("Payment Method",
                           selection: $paymentMethod) {
                        
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
                            category: category,
                            date: date,
                            notes: notes,
                            paymentMethod: paymentMethod,
                            currency: currency,
                            trip: nil
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

    let expense = ExpenseEntity(context: context)

    expense.title = "Dinner"
    expense.amount = 1200
    expense.category = "Food"
    expense.paymentMethod = "Cash"
    expense.currency = "INR"
    expense.date = .now
    expense.notes = "Dinner with friends"

    return EditExpenseView(expense: expense)
        .environmentObject(ExpenseViewModel())
}
