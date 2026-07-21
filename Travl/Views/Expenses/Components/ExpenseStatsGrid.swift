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

            ExpenseStatCard(
                title: "Expenses",
                value: "\(totalExpenses)",
                systemImage: "list.bullet.rectangle.fill",
                color: .blue
            )

            ExpenseStatCard(
                title: "Highest",
                value: "\(currency) \(Int(highestExpense))",
                systemImage: "arrow.up.circle.fill",
                color: .red
            )

            ExpenseStatCard(
                title: "Average",
                value: "\(currency) \(Int(averageExpense))",
                systemImage: "chart.bar.fill",
                color: .green
            )

            ExpenseStatCard(
                title: "Categories",
                value: "\(categories)",
                systemImage: "square.grid.2x2.fill",
                color: .orange
            )
        }
    }
}

#Preview {

    ExpenseStatsGrid(
        totalExpenses: 26,
        highestExpense: 6500,
        averageExpense: 1200,
        categories: 6,
        currency: "₹"
    )
    .padding()
}
