//
//  ExpensesView.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData

struct ExpensesView: View {

    @EnvironmentObject private var expenseViewModel: ExpenseViewModel
    
    let trip: TripEntity?

    @State private var showAddExpense = false
    @State private var showDeleteAlert = false

    private var displayedExpenses: [ExpenseEntity] {

        if let trip {

            return expenseViewModel.expenses
                .filter { $0.trip == trip }
                .sorted {
                    ($0.date ?? .distantPast) >
                    ($1.date ?? .distantPast)
                }

        } else {

            return expenseViewModel.expenses
                .sorted {
                    ($0.date ?? .distantPast) >
                    ($1.date ?? .distantPast)
                }
        }
    }

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            Group {

                if displayedExpenses.isEmpty {

                    ContentUnavailableView(
                        "No Expenses",
                        systemImage: "indianrupeesign.circle",
                        description: Text("Start tracking your trip expenses.")
                    )

                } else {

                    ScrollView {

                        LazyVStack(spacing: 16) {

                            ForEach(displayedExpenses,
                                    id: \.objectID) { expense in

                                NavigationLink {

                                    ExpenseDetailView(
                                        expense: expense
                                    )

                                } label: {

                                    ExpenseCard(
                                        expense: expense
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }

            Button {

                showAddExpense = true

            } label: {

                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 60)
                    .background(.blue)
                    .clipShape(Circle())
                    .shadow(radius: 8)
            }
            .padding()
        }
        .navigationTitle(
            trip == nil
            ? "Expenses"
            : (trip?.destination ?? "Expenses")
        )
        .sheet(isPresented: $showAddExpense) {

            NavigationStack {

                AddExpenseView(trip: trip)
            }
            .environmentObject(expenseViewModel)
        }
    }
}

#Preview {

    NavigationStack {

        ExpensesView(trip: nil)
    }
    .environmentObject(ExpenseViewModel())
}
