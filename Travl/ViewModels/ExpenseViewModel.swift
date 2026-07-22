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
    
    
    
    
    // MARK: - Dashboard Helpers
    
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
    

    func expenses(for trip: TripEntity) -> [ExpenseEntity] {

        let expenses = trip.expenses as? Set<ExpenseEntity> ?? []

        return expenses.sorted {
            ($0.date ?? .distantPast) > ($1.date ?? .distantPast)
        }
    }

    func expenseCount(for trip: TripEntity) -> Int {

        expenses(for: trip).count
    }

    func totalExpenses(for trip: TripEntity) -> Double {

        expenses(for: trip).reduce(0) { $0 + $1.amount }
    }

    func highestExpense(for trip: TripEntity) -> Double {

        expenses(for: trip)
            .map(\.amount)
            .max() ?? 0
    }

    func averageExpense(for trip: TripEntity) -> Double {

        let expenses = expenses(for: trip)

        guard !expenses.isEmpty else { return 0 }

        return totalExpenses(for: trip) / Double(expenses.count)
    }

    func recentExpenses(for trip: TripEntity, limit: Int = 5) -> [ExpenseEntity] {

        Array(expenses(for: trip).prefix(limit))
    }

    func categoryCount(for trip: TripEntity) -> Int {

        Set(
            expenses(for: trip)
                .compactMap(\.category)
        ).count
    }

    func categoryBreakdown(for trip: TripEntity) -> [ExpenseCategory] {

        var categoryAmounts: [String : Double] = [:]

        expenses(for: trip).forEach {

            categoryAmounts[$0.category ?? "Others", default: 0] += $0.amount
        }

        let colorMap: [String: Color] = [

            "Food": .orange,
            "Transport": .green,
            "Hotel": .blue,
            "Shopping": .purple,
            "Activities": .pink,
            "Entertainment": .red,
            "Utilities": .gray,
            "Others": .gray
        ]

        return categoryAmounts.map {

            ExpenseCategory(
                name: $0.key,
                amount: $0.value,
                color: colorMap[$0.key] ?? .gray
            )
        }
        .sorted { $0.amount > $1.amount }
    }
    
    func totalSpent(for trip: TripEntity) -> Double {

        bookingTotal(for: trip) + totalExpenses(for: trip)
    }

    func remainingBudget(for trip: TripEntity) -> Double {

        trip.budget - totalSpent(for: trip)
    }
    
    func bookingCount(for trip: TripEntity) -> Int {

        let bookings = trip.bookings as? Set<BookingEntity> ?? []

        return bookings.count
    }

    func bookingTotal(for trip: TripEntity) -> Double {

        let bookings = trip.bookings as? Set<BookingEntity> ?? []

        return bookings.reduce(0) { $0 + $1.amount }
    }
}
