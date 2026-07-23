//
//  TripBookingsSection.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import CoreData

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
                
                if bookings.count >= 3 {
                    
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
                        NavigationLink {
                            BookingDetailView(booking: booking)
                        } label: {
                            BookingCard(booking: booking)
                        }
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

#Preview {
    let context = PersistenceController.preview.container.viewContext
    
    let trip = TripEntity(context: context)
    
    
    trip.title = "Paris"
    trip.startDate = Date()
    trip.endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
    
    let booking = BookingEntity(context: context)
    
    booking.bookingType = "Hotel"
    booking.currency = "INR"
    booking.amount = 100000
    booking.status = "Pending"
    booking.startDate = Date()
    booking.endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())
    booking.bookingReference = "123456789"
    booking.provider = "Booking.com"
    booking.title = "Hotel"
    booking.notes = "Some notes"
    booking.trip = trip
    
    return NavigationStack{
        TripBookingsSection(trip: trip)
    }
    .environmentObject(BookingViewModel())
}
