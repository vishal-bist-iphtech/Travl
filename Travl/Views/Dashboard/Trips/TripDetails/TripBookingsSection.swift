//
//  TripBookingsSection.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI

struct TripBookingsSection: View {

    @ObservedObject var trip: TripEntity

    @EnvironmentObject private var bookingViewModel: BookingViewModel

    @State private var showBookingOptions = false
    @State private var bookingSheet: BookingSheet?

    enum BookingSheet: Identifiable {
        case add
        case select

        var id: Self { self }
    }

    private var bookings: [BookingEntity] {

        let set = trip.bookings as? Set<BookingEntity> ?? []

        return set.sorted {
            ($0.startDate ?? .distantFuture) <
            ($1.startDate ?? .distantFuture)
        }
    }

    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                
                Text("Bookings")
                    .font(.title3.bold())
                
                Spacer()
                
                if bookings.count > 3 {
                    
                    NavigationLink("See All") {
                        
                        BookingsView(trip: trip)
                    }
                } else {
                    Button {
                        showBookingOptions = true
                    } label: {
                        
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            
            if bookings.isEmpty {
                
                ContentUnavailableView(
                    "No Bookings",
                    systemImage: "ticket",
                    description: Text("This trip doesn't have any bookings yet.")
                )
                
            } else {
                
                TabView {
                    ForEach(bookings.prefix(3), id: \.objectID) { booking in
                        BookingCard(booking: booking)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 230)
            }
        }
        .confirmationDialog(
            "Add Bookings",
            isPresented: $showBookingOptions,
            titleVisibility: .visible
        ) {
            
            Button("Create New Booking") {
                
                bookingSheet = .add
            }
            
            Button("Add Existing Booking") {
                
                bookingSheet = .select
            }
            
        }
        .sheet(item: $bookingSheet) { sheet in
            switch sheet {
            case .add:
                NavigationStack {
                    AddBookingView(trip: trip)
                }
                
            case .select:
                NavigationStack {
                    SelectBookingView(trip: trip)
                        .environmentObject(bookingViewModel)
                }
            }
        }
        .padding()
    }
}
