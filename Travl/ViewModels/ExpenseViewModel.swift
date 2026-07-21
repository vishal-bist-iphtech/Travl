//
//  ExpenseViewModel.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData
import Combine

final class ExpenseViewModel: ObservableObject {

    @Published private(set) var expenses: [ExpenseEntity] = []
    
    @EnvironmentObject private var tripViewModel: TripViewModel

    private let coreDataService = CoreDataService.shared

    init() {
        loadExpenses()
    }

    func loadExpenses() {
        expenses = coreDataService.fetchExpenses()
    }

    func refresh() {
        loadExpenses()
    }

    func addExpense(
        title: String,
        amount: Double,
        category: String,
        date: Date,
        notes: String,
        paymentMethod: String,
        currency: String,
        trip: TripEntity?
    ) {

        coreDataService.addExpense(
            title: title,
            amount: amount,
            category: category,
            date: date,
            notes: notes,
            paymentMethod: paymentMethod,
            currency: currency,
            trip: trip
        )

        loadExpenses()
    }

    func deleteExpense(_ expense: ExpenseEntity) {

        coreDataService.deleteExpense(expense)

        refresh()
    }

    func updateExpense(
        expense: ExpenseEntity,
        title: String,
        amount: Double,
        category: String,
        date: Date,
        notes: String,
        paymentMethod: String,
        currency: String
    ) {

        coreDataService.updateExpense(
            expense: expense,
            title: title,
            amount: amount,
            category: category,
            date: date,
            notes: notes,
            paymentMethod: paymentMethod,
            currency: currency
        )

        refresh()
    }
    
    
    var totalExpenses: Int {

        expenses.count
    }
    
    var totalSpent: Double {

        expenses.reduce(0) { $0 + $1.amount }
    }
    
    var highestExpense: Double {

        expenses.map(\.amount).max() ?? 0
    }
    
    var averageExpense: Double {

        guard !expenses.isEmpty else { return 0 }

        return totalSpent / Double(expenses.count)
    }
    
    var categoryCount: Int {

        Set(
            expenses.compactMap {
                $0.category
            }
        ).count
    }
    
    var currency: String {

        expenses.first?.currency ?? "₹"
    }
    
    var totalBudget: Double {

        80000
    }
    
    var categoryBreakdown: [ExpenseCategory] {

        let grouped = Dictionary(
            grouping: expenses,
            by: { $0.category ?? "Others" }
        )

        let colors: [Color] = [
            .blue,
            .green,
            .orange,
            .purple,
            .pink,
            .red,
            .teal,
            .indigo
        ]

        return grouped.enumerated().map { index, item in

            let (category, values) = item

            return ExpenseCategory(
                name: category,
                amount: values.reduce(0) { $0 + $1.amount },
                color: colors[index % colors.count]
            )
        }
    }
    
    func spentAmount(for trip: TripEntity) -> Double {

        expenses
            .filter { $0.trip == trip }
            .reduce(0) { $0 + $1.amount }
    }
    
}
