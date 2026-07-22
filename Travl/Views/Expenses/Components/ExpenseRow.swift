//
//  ExpenseRow.swift
//  Travl
//
//  Created by iPHTech 34 on 22/07/26.
//

import SwiftUI
import CoreData

struct ExpenseRow: View {

    @ObservedObject var expense: ExpenseEntity

    private var icon: String {

        switch expense.category {

        case "Food":
            return "fork.knife"

        case "Transport":
            return "car.fill"

        case "Shopping":
            return "bag.fill"

        case "Accommodation":
            return "bed.double.fill"

        case "Entertainment":
            return "gamecontroller.fill"

        default:
            return "creditcard.fill"
        }
    }

    var body: some View {

        HStack(spacing: 16) {

            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 45, height: 45)
                .background(.blue.opacity(0.15))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {

                Text(expense.title ?? "")
                    .fontWeight(.semibold)

                Text(expense.category ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing) {

                Text("\(expense.currency ?? "INR") \(Int(expense.amount))")
                    .fontWeight(.bold)

                Text(
                    expense.date?.formatted(
                        date: .abbreviated,
                        time: .omitted
                    ) ?? ""
                )
                .font(.caption2)
                .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

#Preview {

    let context = PersistenceController.preview.container.viewContext

    let expense = ExpenseEntity(context: context)

    expense.title = "Dinner"
    expense.amount = 850
    expense.currency = "INR"
    expense.category = "Food"
    expense.date = .now

    return ExpenseRow(expense: expense)
        .padding()
}
