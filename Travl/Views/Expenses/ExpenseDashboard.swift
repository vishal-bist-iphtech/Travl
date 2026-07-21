//
//  ExpenseDashboard.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

//
//  ExpenseDashboardView.swift
//  Travl
//

import SwiftUI

struct ExpenseDashboardView: View {

    @EnvironmentObject private var expenseViewModel: ExpenseViewModel

    @State private var showAddExpense = false

    // MARK: - Mock Data

    private let budget: Double = 80000
    private let spent: Double = 32750
    private let currency = "₹"

    private let totalExpenses = 28
    private let highestExpense = 12500
    private let averageExpense = 1170
    private let categoryCount = 6

    private let categoryData: [ExpenseCategory] = [
        ExpenseCategory(name: "Hotel", amount: 12500, color: .blue),
        ExpenseCategory(name: "Food", amount: 7600, color: .orange),
        ExpenseCategory(name: "Transport", amount: 4200, color: .green),
        ExpenseCategory(name: "Shopping", amount: 5100, color: .purple),
        ExpenseCategory(name: "Activities", amount: 2300, color: .pink),
        ExpenseCategory(name: "Others", amount: 1050, color: .gray)
    ]

    var body: some View {

        NavigationStack {

            ZStack(alignment: .bottomTrailing) {

                ScrollView {

                    VStack(spacing: 20) {

                        BudgetSummaryCard(
                            budget: budget,
                            spent: spent,
                            currency: currency
                        )

                        ExpenseStatsGrid(
                            totalExpenses: totalExpenses,
                            highestExpense: Double(highestExpense),
                            averageExpense: Double(averageExpense),
                            categories: categoryCount,
                            currency: currency
                        )

                        ExpenseCategoryChart(
                            categories: categoryData
                        )

                        // MARK: Recent Expenses

                        VStack(alignment: .leading, spacing: 16) {

                            HStack {

                                Text("Recent Expenses")
                                    .font(.title3.bold())

                                Spacer()

                                Button("See All") {

                                }
                            }

                            ExpenseMockCard(
                                icon: "bed.double.fill",
                                title: "Hilton Hotel",
                                category: "Hotel",
                                amount: 12500,
                                date: "Today"
                            )

                            ExpenseMockCard(
                                icon: "fork.knife",
                                title: "Dinner",
                                category: "Food",
                                amount: 1850,
                                date: "Yesterday"
                            )

                            ExpenseMockCard(
                                icon: "car.fill",
                                title: "Uber Airport",
                                category: "Transport",
                                amount: 620,
                                date: "20 Jul"
                            )

                            ExpenseMockCard(
                                icon: "bag.fill",
                                title: "Shopping",
                                category: "Shopping",
                                amount: 3200,
                                date: "19 Jul"
                            )

                            ExpenseMockCard(
                                icon: "figure.hiking",
                                title: "Scuba Diving",
                                category: "Activity",
                                amount: 4800,
                                date: "18 Jul"
                            )
                        }
                    }
                    .padding()
                    .padding(.bottom, 90)
                }

                Button {

                    showAddExpense = true

                } label: {

                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(.blue)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding()
            }
            .navigationTitle("Expenses")
            .sheet(isPresented: $showAddExpense) {

                NavigationStack {

                    AddExpenseView(trip: nil)
                }
                .environmentObject(expenseViewModel)
            }
        }
    }
}

// MARK: - Mock Expense Card

private struct ExpenseMockCard: View {

    let icon: String
    let title: String
    let category: String
    let amount: Double
    let date: String

    var body: some View {

        HStack(spacing: 16) {

            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 50, height: 50)
                .background(.blue.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {

                Text(title)
                    .font(.headline)

                Text(category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {

                Text("₹\(Int(amount))")
                    .fontWeight(.semibold)

                Text(date)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.08), radius: 4)
    }
}

#Preview {

    ExpenseDashboardView()
        .environmentObject(ExpenseViewModel())
}
