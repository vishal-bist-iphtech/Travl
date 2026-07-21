//
//  RecentExpenseSection.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI

struct RecentExpenseSection: View {

    @EnvironmentObject private var expenseViewModel: ExpenseViewModel

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                Text("Recent Expenses")
                    .font(.title3.bold())

                Spacer()

                NavigationLink("See All") {

                    ExpensesView(trip: nil)
                }
            }

            if expenseViewModel.expenses.isEmpty {

                ContentUnavailableView(
                    "No Expenses",
                    systemImage: "indianrupeesign.circle",
                    description: Text("Start tracking your travel expenses.")
                )

            } else {

                ForEach(
                    expenseViewModel.expenses.prefix(5),
                    id: \.objectID
                ) { expense in

                    NavigationLink {

                        ExpenseDetailView(expense: expense)

                    } label: {

                        ExpenseCard(expense: expense)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {

    NavigationStack {

        RecentExpenseSection()
            .padding()
            .environmentObject(ExpenseViewModel())
    }
}
