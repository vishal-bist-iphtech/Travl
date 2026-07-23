//
//  BookingsView.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//

import SwiftUI

struct BookingsView: View {

    @EnvironmentObject private var bookingViewModel: BookingViewModel
    
    let trip: TripEntity?

    @State private var showAddBooking = false
    
    private var displayedBookings: [BookingEntity] {

        if let trip {

            return bookingViewModel.bookings
                .filter { $0.trip == trip }
                .sorted {
                    ($0.startDate ?? .distantFuture) <
                    ($1.startDate ?? .distantFuture)
                }

        } else {

            return bookingViewModel.bookings
                .sorted {
                    ($0.startDate ?? .distantFuture) >
                    ($1.startDate ?? .distantFuture)
                }
        }
    }

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            Group {

                if bookingViewModel.bookings.isEmpty {

                    ContentUnavailableView(
                        "No Bookings",
                        systemImage: "ticket",
                        description: Text("Start adding your travel bookings.")
                    )

                } else {

                    ScrollView {

                        LazyVStack(spacing: 16) {

                            ForEach(displayedBookings,
                                    id: \.objectID) { booking in

                                NavigationLink {

                                    BookingDetailView(
                                        booking: booking
                                    )

                                } label: {

                                    BookingCard(
                                        booking: booking
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

                showAddBooking = true

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
            ? "Bookings"
            : "\(trip?.title ?? "") Bookings"
        )
        .sheet(isPresented: $showAddBooking) {

            NavigationStack {

                AddBookingView(trip: trip)
            }
            .environmentObject(bookingViewModel)
        }
    }
}

#Preview {

    NavigationStack {

        BookingsView(trip: nil)
    }
    .environmentObject(BookingViewModel())
}
