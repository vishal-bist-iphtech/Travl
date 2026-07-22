//
//  TripCostBreakdownCard.swift
//  Travl
//
//  Created by iPHTech 34 on 22/07/26.
//

import SwiftUI

struct TripCostBreakdownCard: View {

    let bookingTotal: Double
    let expenseTotal: Double
    let currency: String

    private var total: Double {
        bookingTotal + expenseTotal
    }

    private var bookingProgress: Double {
        guard total > 0 else { return 0 }
        return bookingTotal / total
    }

    private var expenseProgress: Double {
        guard total > 0 else { return 0 }
        return expenseTotal / total
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            Text("Trip Cost Breakdown")
                .font(.headline)

            VStack(spacing: 18) {

                CostRow(
                    title: "Bookings",
                    icon: "airplane",
                    color: .blue,
                    amount: bookingTotal,
                    currency: currency,
                    progress: bookingProgress
                )

                CostRow(
                    title: "Expenses",
                    icon: "creditcard.fill",
                    color: .orange,
                    amount: expenseTotal,
                    currency: currency,
                    progress: expenseProgress
                )
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 8)
    }
}

private struct CostRow: View {

    let title: String
    let icon: String
    let color: Color
    let amount: Double
    let currency: String
    let progress: Double

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            HStack {

                Label(title, systemImage: icon)

                Spacer()

                Text("\(currency) \(Int(amount))")
                    .fontWeight(.semibold)
            }

            ProgressView(value: progress)
                .tint(color)

            Text("\(Int(progress * 100))% of trip spending")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {

    TripCostBreakdownCard(
        bookingTotal: 52000,
        expenseTotal: 13500,
        currency: "INR"
    )
    .padding()
}
