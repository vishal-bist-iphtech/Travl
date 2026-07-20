//
//  BookingsView.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//

import SwiftUI

struct BookingsView: View {

    @EnvironmentObject private var bookingViewModel: BookingViewModel

    @State private var showAddBooking = false

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

                            ForEach(bookingViewModel.bookings,
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
        .navigationTitle("Bookings")
        .sheet(isPresented: $showAddBooking) {

            NavigationStack {

                AddBookingView()
            }
            .environmentObject(bookingViewModel)
        }
    }
}

#Preview {

    NavigationStack {

        BookingsView()
    }
    .environmentObject(BookingViewModel())
}
