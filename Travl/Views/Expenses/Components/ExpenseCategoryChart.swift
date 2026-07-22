//
//  ExpenseCategoryChart.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import Charts

struct ExpenseCategoryChart: View {
    
    @State private var selectedCategory: ExpenseCategory?

    let categories: [ExpenseCategory]
    
    private var totalAmount: Double {

        categories.reduce(0) { result, category in
            result + category.amount
        }
    }

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

                    innerRadius: .ratio(0.3),

                    angularInset: 0.5,
                )
                .foregroundStyle(category.color)
                
            }
            .frame(height: 250)
            
            if let selectedCategory {

                VStack(spacing: 8) {

                    Text(selectedCategory.name)
                        .font(.headline)

                    Text("₹\(Int(selectedCategory.amount))")
                        .font(.title.bold())

                    Text(
                        "\(Int((selectedCategory.amount)/totalAmount * 100))% of expenses"
                    )
                    .foregroundStyle(.secondary)
                }
                .padding(.top)
            }

            Divider()

            VStack(spacing: 14) {

                ForEach(categories) { category in

                    ExpenseCategoryRow(category: category)
                        .onTapGesture {

                            selectedCategory = category
                        }
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
