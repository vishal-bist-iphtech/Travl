//
//  ExpenseStatGrid.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

//
//  ExpenseStatsGrid.swift
//  Travl
//

import SwiftUI

struct ExpenseStatsGrid: View {

    let totalBookings: Int
    let totalExpenses: Int
    let highestExpense: Double
    let averageExpense: Double
    let categories: Int
    let currency: String

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        LazyVGrid(columns: columns, spacing: 16) {

            StatCard(
                title: "Bookings",
                value: "\(totalBookings)",
                icon: "airplane",
                color: .blue
            )

            StatCard(
                title: "Expenses",
                value: "\(totalExpenses)",
                icon: "creditcard.fill",
                color: .orange
            )

            StatCard(
                title: "Highest",
                value: "\(currency) \(Int(highestExpense))",
                icon: "arrow.up.circle.fill",
                color: .red
            )

            StatCard(
                title: "Average",
                value: "\(currency) \(Int(averageExpense))",
                icon: "chart.bar.fill",
                color: .green
            )

            StatCard(
                title: "Categories",
                value: "\(categories)",
                icon: "square.grid.2x2.fill",
                color: .purple
            )
        }
    }
}

private struct StatCard: View {

    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Spacer()

            Text(value)
                .font(.title2.bold())

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 110)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.08), radius: 6)
    }
}

#Preview {

    ExpenseStatsGrid(
        totalBookings: 5,
        totalExpenses: 18,
        highestExpense: 8500,
        averageExpense: 1450,
        categories: 6,
        currency: "INR"
    )
    .padding()
}
