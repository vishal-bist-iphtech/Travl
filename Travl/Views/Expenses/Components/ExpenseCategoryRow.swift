//
//  ExpenseCategoryRow.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//
import SwiftUI

struct ExpenseCategoryRow: View {

    let category: ExpenseCategory

    var body: some View {

        HStack {

            Circle()
                .fill(category.color)
                .frame(width: 12, height: 12)

            Text(category.name)

            Spacer()

            Text("₹ \(Int(category.amount))")
                .fontWeight(.semibold)
        }
    }
}

#Preview {

    ExpenseCategoryRow(

        category: ExpenseCategory(
            name: "Food",
            amount: 2400,
            color: .orange
        )
    )
    .padding()
}
