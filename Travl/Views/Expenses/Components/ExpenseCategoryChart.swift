//
//  ExpenseCategoryChart.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import Charts

struct ExpenseCategoryChart: View {

    let categories: [ExpenseCategory]

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            Text("Expense Breakdown")
                .font(.title3.bold())

            Chart(categories) { category in

                SectorMark(

                    angle: .value(
                        "Amount",
                        category.amount
                    ),

                    innerRadius: .ratio(0.60),

                    angularInset: 2
                )
                .foregroundStyle(category.color)
            }
            .frame(height: 250)

            Divider()

            VStack(spacing: 14) {

                ForEach(categories) { category in

                    ExpenseCategoryRow(category: category)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.08), radius: 8)
    }
}

#Preview {

    ExpenseCategoryChart(

        categories: [

            ExpenseCategory(
                name: "Food",
                amount: 5200,
                color: .orange
            ),

            ExpenseCategory(
                name: "Hotel",
                amount: 14500,
                color: .blue
            ),

            ExpenseCategory(
                name: "Transport",
                amount: 3800,
                color: .green
            ),

            ExpenseCategory(
                name: "Shopping",
                amount: 6100,
                color: .purple
            ),

            ExpenseCategory(
                name: "Activities",
                amount: 2500,
                color: .pink
            ),
            
            ExpenseCategory(
                name: "Others",
                amount: 2500,
                color: .gray
            )
        ]
    )
    .padding()
}
