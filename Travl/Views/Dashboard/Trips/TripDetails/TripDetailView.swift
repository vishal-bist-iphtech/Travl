//
//  TripDetailView.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import SwiftUI
import CoreData

struct TripDetailView: View {
    
    @ObservedObject var trip: TripEntity
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tripViewModel: TripViewModel
  
    @State private var showDeleteAlert = false
    

    var body: some View {
            ScrollView {
                
                TripInfoSection(trip:trip)
                    .padding()
                
                TripMemoriesSection(trip: trip)
                    .padding(.horizontal)
                
                TripBookingsSection(trip: trip)
                    .padding(.horizontal)
            }
            .navigationTitle("Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    NavigationLink {
                        
                        EditTripView(trip: trip)
                            .environmentObject(tripViewModel)
                        
                    } label: {
                        
                        Image(systemName: "square.and.pencil")
                    }
                    
                    Button(role: .destructive) {
                        
                        showDeleteAlert = true
                        
                    } label: {
                        
                        Image(systemName: "trash")
                    }
                }
            }
            .alert("Delete Trip?", isPresented: $showDeleteAlert) {
                
                Button("Delete", role: .destructive) {
                    
                    tripViewModel.deleteTrip(trip)
                    
                    dismiss()
                }
                
                Button("Cancel", role: .cancel) { }
                
            } message: {
                
                Text("This action cannot be undone.")
            }
    }
}
            



#Preview {

    let context = PersistenceController.shared.container.viewContext

    @ObservedObject var trip = TripEntity(context: context)

    trip.destination = "Paris"
    trip.city = "Paris"
    trip.country = "France"
    trip.currency = "INR"
    trip.budget = 100000
    trip.status = "Upcoming"
    trip.startDate = Date()
    trip.endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())

    return NavigationStack {

        TripDetailView(
            trip: trip
        )
    }
    .environmentObject(
        TripViewModel()
    )
    .environmentObject(MemoryViewModel())
    .environmentObject(BookingViewModel())
}
