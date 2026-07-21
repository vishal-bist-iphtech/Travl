//
//  ExpenseStatCard.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI

struct ExpenseStatCard: View {

    let title: String
    let value: String
    let systemImage: String
    let color: Color

    var body: some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack {

                Image(systemName: systemImage)
                    .font(.title3)
                    .foregroundStyle(color)

                Spacer()
            }

            VStack(alignment: .leading, spacing: 4) {

                Text(value)
                    .font(.title2.bold())

                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.08), radius: 8)
    }
}

#Preview {

    HStack {

        ExpenseStatCard(
            title: "Expenses",
            value: "42",
            systemImage: "list.bullet",
            color: .blue
        )

        ExpenseStatCard(
            title: "Highest",
            value: "₹8,500",
            systemImage: "arrow.up.circle.fill",
            color: .red
        )
    }
    .padding()
}
