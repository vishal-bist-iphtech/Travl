//
//  ExpenseCard.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData

struct ExpenseCard: View {
    
    let expense: ExpenseEntity
    let currency: String
    
    private var icon: String {
        switch expense.category {
        case "Hotel": return "bed.double.fill"
        case "Food": return "fork.knife"
        case "Transport": return "car.fill"
        case "Shopping": return "bag.fill"
        case "Activities": return "figure.hiking"
        case "Entertainment": return "tv.fill"
        default: return "dollarsign.circle"
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 50, height: 50)
                .background(.blue.opacity(0.12))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title ?? "Untitled")
                    .font(.headline)
                    .background(.clear)
                
                if let category = expense.category {
                    Text(category)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(currency)\(Int(expense.amount))")
                    .fontWeight(.semibold)
                
                if let date = expense.date {
                    Text(date.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.08), radius: 4)
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

    return ExpenseCard(expense: expense, currency: "INR")
        .padding()
}
