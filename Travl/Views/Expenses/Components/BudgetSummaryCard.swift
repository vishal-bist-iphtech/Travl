//
//  BudgetSummaryCard.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI

struct BudgetSummaryCard: View {

    let budget: Double
    let bookingTotal: Double
    let expenseTotal: Double
    let totalSpent: Double
    let remaining: Double
    let currency: String

    private var progress: Double {

        guard budget > 0 else { return 0 }

        return min(totalSpent / budget, 1.0)
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            VStack(alignment: .leading, spacing: 4) {

                Text("Trip Budget")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text("\((currency).currencySymbol)\(Int(budget))")
                    .font(.system(size: 34, weight: .bold))
            }

            ProgressView(value: progress)
                .tint(progress > 0.9 ? .red :
                        progress > 0.7 ? .orange : .blue)
                .scaleEffect(y: 3)

            HStack(spacing: 20) {

                BudgetValueView(
                    title: "Bookings",
                    value: bookingTotal,
                    currency: currency.currencySymbol,
                    color: .blue,
                    icon: "airplane"
                )

                Spacer()

                BudgetValueView(
                    title: "Expenses",
                    value: expenseTotal,
                    currency: currency.currencySymbol,
                    color: .orange,
                    icon: "creditcard"
                )
            }

            Divider()

            HStack {

                VStack(alignment: .leading) {

                    Text("Total Spent")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text("\((currency).currencySymbol) \(Int(totalSpent))")
                        .font(.title3.bold())
                }

                Spacer()

                VStack(alignment: .trailing) {

                    Text("Remaining")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text("\((currency).currencySymbol) \(Int(remaining))")
                        .font(.title3.bold())
                        .foregroundStyle(
                            remaining >= 0 ? .green : .red
                        )
                }
            }
        }
        .padding()
        .background(
            LinearGradient(colors: [.cyan, .blue], startPoint: .leading, endPoint: .trailing).opacity(0.4)
        )
        .overlay(alignment: .topTrailing) {
            Circle()
                .foregroundStyle(.white).opacity(0.1)
                .frame(height: 180)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 8)
    }
}

private struct BudgetValueView: View {

    let title: String
    let value: Double
    let currency: String
    let color: Color
    let icon: String

    var body: some View {

        VStack(alignment: .leading, spacing: 6) {

            Label(title, systemImage: icon)
                .font(.caption)
                .foregroundStyle(color)

            Text("\((currency).currencySymbol )\(Int(value))")
                .font(.headline.bold())
        }
    }
}

#Preview {

    BudgetSummaryCard(
        budget: 100000,
        bookingTotal: 52000,
        expenseTotal: 13500,
        totalSpent: 65500,
        remaining: 34500,
        currency: "INR"
    )
    .padding()
}
