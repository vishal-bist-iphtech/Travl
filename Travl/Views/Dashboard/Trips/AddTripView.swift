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
    
    @State private var destionation = ""
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
                
                Section("Destination") {
                    
                    TextField("Destination", text: $destionation)
                    
                    TextField("Country", text: $country)
                    
                    TextField("City", text: $city)
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
                    
                    TextField("Budget", text: $budget)
                        .keyboardType(.decimalPad)
                    
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(tripViewModel.currencies, id: \.self) {
                            Text($0)
                        }
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
                        
                        guard !destionation.isEmpty,!country.isEmpty,!city.isEmpty,
                              let budgetValue = Double(budget)
                        else { return }
                        
                        tripViewModel.addTrip(
                            destination: destionation,
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
