//
//  AddTripView.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import SwiftUI

struct AddTripView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var tripViewModel: TripViewModel
    
    @State private var title = ""
    @State private var country = ""
    @State private var city = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var budget = ""
    @State private var selectedCurrency = "INR"
    @State private var selectedStatus = "Upcoming"
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Title") {
                    
                    TextField("Title", text: $title)
                    TextField("City", text: $city)
                    TextField("State or Country", text: $country)
                    
                    
                }
                
                Section("Travel Dates") {
                    
                    DatePicker(
                        "Start Date",
                        selection: $startDate,
                        displayedComponents: .date
                    )
                    
                    DatePicker(
                        "End Date",
                        selection: $endDate,
                        displayedComponents: .date
                    )
                }
                
                Section("Budget") {
                    
                    HStack(spacing: 10){
                        
                        
                       Menu {
                            
                            ForEach(tripViewModel.currencies, id: \.self) { currency in
                                Button(currency) {
                                    selectedCurrency = currency
                                }
                            }
                       } label: {
                           HStack(spacing: 4) {
                               Text(selectedCurrency)
                               Image(systemName: "chevron.down")
                                   .font(.caption2)
                           }
                           .frame(width: 60)
                       }
                        Divider()
                            .background(Color.primary)
                        TextField("Budget", text: $budget)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 18))
                            .padding(.horizontal)
                    }
                }
                
                Section("Status") {
                    
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(tripViewModel.statuses, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("Add Trip")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                        guard !title.isEmpty,!country.isEmpty,!city.isEmpty,
                              let budgetValue = Double(budget)
                        else { return }
                        
                        tripViewModel.addTrip(
                            title: title,
                            country: country,
                            city: city,
                            startDate: startDate,
                            endDate: endDate,
                            budget: budgetValue,
                            currency: selectedCurrency,
                            status: selectedStatus
                        )
                        
                        dismiss()
                    }
                    .disabled(
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }
            }
        }
        
    }
}


#Preview {
    AddTripView()
        .environmentObject(
            TripViewModel()
        )
}
