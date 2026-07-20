//
//  EditTripView.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import SwiftUI
import CoreData

struct EditTripView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tripViewModel: TripViewModel

    let trip: TripEntity

    @State private var destination: String
    @State private var country: String
    @State private var city: String
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var budget: String
    @State private var selectedCurrency: String
    @State private var selectedStatus: String

    @State private var showDeleteConfirmation = false

    init(trip: TripEntity) {

        self.trip = trip

        _destination = State(initialValue: trip.destination ?? "")
        _country = State(initialValue: trip.country ?? "")
        _city = State(initialValue: trip.city ?? "")
        _startDate = State(initialValue: trip.startDate ?? Date())
        _endDate = State(initialValue: trip.endDate ?? Date())
        _budget = State(initialValue: "\(trip.budget)")
        _selectedCurrency = State(initialValue: trip.currency ?? "INR")
        _selectedStatus = State(initialValue: trip.status ?? "Upcoming")
    }

    var body: some View {

        Form {

            Section("Destination") {

                TextField("Title", text: $destination)
                TextField("City", text: $city)
                TextField("Country", text: $country)
                
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
                       .frame(width: 50)
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
        .navigationTitle("Edit Trip")
        .toolbar {
            
//            ToolbarItem(placement: .topBarLeading) {
//                Button("Cancel") {
//                    dismiss()
//                }
//            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    
                    guard
                        !destination.isEmpty,
                        !country.isEmpty,
                        !city.isEmpty,
                        let budgetValue = Double(budget)
                    else {
                        return
                    }

                    tripViewModel.updateTrip(
                        trip: trip,
                        destination: destination,
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

#Preview {

    let context = PersistenceController.shared.container.viewContext

    let trip = TripEntity(context: context)

    trip.destination = "Big Ben"
    trip.country = "France"
    trip.city = "Paris"
    trip.budget = 120000
    trip.currency = "INR"
    trip.status = "Upcoming"
    trip.startDate = Date()
    trip.endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())

    return NavigationStack {

        EditTripView(trip: trip)
    }
    .environmentObject(TripViewModel())
}
