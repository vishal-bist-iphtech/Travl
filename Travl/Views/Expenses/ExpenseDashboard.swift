//
//  ExpenseDashboard.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData

struct ExpenseDashboardView: View {

    @EnvironmentObject private var expenseViewModel: ExpenseViewModel
    @EnvironmentObject private var tripViewModel: TripViewModel

    @State private var showAddExpense = false

    private var currentTrip: TripEntity? {

        tripViewModel.nextTrip
    }

    private var currency: String {

        currentTrip?.currency?.currencySymbol ?? "₹"
    }

    var body: some View {

        NavigationStack {

            ZStack(alignment: .bottomTrailing) {

                ScrollView {

                    if let trip = currentTrip {

                        VStack(spacing: 20) {

                            BudgetSummaryCard(

                                budget: trip.budget,

                                bookingTotal: expenseViewModel.bookingTotal(for: trip),

                                expenseTotal: expenseViewModel.totalExpenses(for: trip),

                                totalSpent: expenseViewModel.totalSpent(for: trip),

                                remaining: expenseViewModel.remainingBudget(for: trip),

                                currency: currency
                            )

                            TripCostBreakdownCard(

                                bookingTotal: expenseViewModel.bookingTotal(for: trip),

                                expenseTotal: expenseViewModel.totalExpenses(for: trip),

                                currency: currency
                            )

                            ExpenseStatsGrid(

                                totalBookings: expenseViewModel.bookingCount(for: trip),

                                totalExpenses: expenseViewModel.expenseCount(for: trip),

                                highestExpense: expenseViewModel.highestExpense(for: trip),

                                averageExpense: expenseViewModel.averageExpense(for: trip),

                                categories: expenseViewModel.categoryCount(for: trip),

                                currency: currency
                            )

                            if !expenseViewModel.categoryBreakdown(for: trip).isEmpty {

                                ExpenseCategoryChart(

                                    categories: expenseViewModel.categoryBreakdown(for: trip)
                                )
                            }

                            VStack(alignment: .leading, spacing: 16) {

                                HStack {

                                    Text("Recent Expenses")
                                        .font(.title3.bold())

                                    Spacer()

                                    if !expenseViewModel.recentExpenses(for: trip).isEmpty {

                                        Button("See All") {

                                        }
                                    }
                                }

                                if expenseViewModel.recentExpenses(for: trip).isEmpty {

                                    ContentUnavailableView(

                                        "No Expenses",

                                        systemImage: "dollarsign.circle",

                                        description: Text("Add your first expense to start tracking.")
                                    )

                                } else {

                                    ForEach(

                                        expenseViewModel.recentExpenses(for: trip),

                                        id: \.objectID

                                    ) { expense in

                                        ExpenseCard(

                                            expense: expense,

                                            currency: currency
                                        )
                                    }
                                }
                            }
                        }
                        .padding()
                        .padding(.bottom, 90)

                    } else {

                        ContentUnavailableView(

                            "No Upcoming Trip",

                            systemImage: "airplane",

                            description: Text("Create a trip to start tracking expenses.")
                        )
                        .padding()
                    }
                }

                Button {

                    showAddExpense = true

                } label: {

                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(.blue)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding()
            }
            
            .navigationTitle("Expenses")
            .navigationTitle("Expenses")
            .onAppear {

                tripViewModel.refresh()
                expenseViewModel.refresh()
            }
            .sheet(isPresented: $showAddExpense) {

                NavigationStack {

                    AddExpenseView(trip: currentTrip)
                }
                .environmentObject(expenseViewModel)
            }
        }
    }
}

#Preview {

    ExpenseDashboardView()
        .environmentObject(ExpenseViewModel())
        .environmentObject(TripViewModel())
}
