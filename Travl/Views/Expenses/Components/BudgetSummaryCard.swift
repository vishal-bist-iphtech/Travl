//
//  BudgetSummaryCard.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI

struct BudgetSummaryCard: View {

    let budget: Double
    let spent: Double
    let currency: String

    private var remaining: Double {
        max(budget - spent, 0)
    }

    private var progress: Double {

        guard budget > 0 else { return 0 }

        return min(spent / budget, 1.0)
    }

    private var progressColor: Color {

        switch progress {

        case 0..<0.5:
            return .green

        case 0.5..<0.8:
            return .orange

        default:
            return .red
        }
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {

                VStack(alignment: .leading, spacing: 4) {

                    Text("Trip Budget")
                        .font(.headline)

                    Text("Track your spending")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "wallet.pass.fill")
                    .font(.title)
                    .foregroundStyle(.blue)
            }

            ProgressView(value: progress)
                .tint(progressColor)

            HStack {

                BudgetValueView(
                    title: "Budget",
                    value: budget,
                    currency: currency,
                    color: .blue
                )

                Spacer()

                BudgetValueView(
                    title: "Spent",
                    value: spent,
                    currency: currency,
                    color: .red
                )

                Spacer()

                BudgetValueView(
                    title: "Remaining",
                    value: remaining,
                    currency: currency,
                    color: .green
                )
            }

            Text("\(Int(progress * 100))% of budget used")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.08), radius: 8)
    }
}

private struct BudgetValueView: View {

    let title: String
    let value: Double
    let currency: String
    let color: Color

    var body: some View {

        VStack(alignment: .leading, spacing: 6) {

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("\(currency) \(Int(value))")
                .font(.headline)
                .foregroundStyle(color)
        }
    }
}

#Preview {

    VStack {

        BudgetSummaryCard(
            budget: 80000,
            spent: 26500,
            currency: "₹"
        )
        .padding()

        Spacer()
    }
}
