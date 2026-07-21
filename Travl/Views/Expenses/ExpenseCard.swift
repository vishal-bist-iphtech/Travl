//
//  ExpenseCard.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData

struct ExpenseCard: View {

    @ObservedObject var expense: ExpenseEntity

    private var categoryIcon: String {

        switch expense.category {

        case "Food":
            return "fork.knife"

        case "Transport":
            return "car.fill"

        case "Hotel":
            return "bed.double.fill"

        case "Shopping":
            return "bag.fill"

        case "Activity":
            return "ticket.fill"

        case "Flight":
            return "airplane"

        default:
            return "indianrupeesign.circle.fill"
        }
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                Image(systemName: categoryIcon)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .background(.blue)
                    .clipShape(Circle())

                VStack(alignment: .leading) {

                    Text(expense.title ?? "")
                        .font(.headline)

                    Text(expense.category ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(expense.currency ?? "") \(Int(expense.amount))")
                    .font(.headline)
                    .foregroundStyle(.red)
            }

            Divider()

            HStack {

                Label(
                    expense.date?.formatted(date: .abbreviated,
                                            time: .omitted) ?? "",
                    systemImage: "calendar"
                )

                Spacer()

                Text(expense.paymentMethod ?? "")
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.08),
                radius: 6,
                y: 2)
    }
}


#Preview {

    let context = PersistenceController.preview.container.viewContext

    let expense = ExpenseEntity(context: context)

    expense.title = "Dinner"

    expense.amount = 1200

    expense.category = "Food"

    expense.currency = "INR"

    expense.paymentMethod = "Credit Card"

    expense.date = .now

    return ExpenseCard(expense: expense)
        .padding()
}
