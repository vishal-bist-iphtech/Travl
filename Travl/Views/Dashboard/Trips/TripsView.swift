//
//  TripsView.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import SwiftUI
import CoreData

struct TripsView: View {

    @EnvironmentObject private var tripViewModel: TripViewModel
    
    @State private var showAddTrip = false

    var body: some View {

        NavigationStack {

            ZStack(alignment: .bottomTrailing) {

                Group {

                    if tripViewModel.trips.isEmpty {

                        ContentUnavailableView(
                            "No Trips Yet",
                            systemImage: "airplane",
                            description: Text("Tap + to plan your first trip.")
                        )

                    } else {

                        ScrollView {

                            LazyVStack(spacing: 16) {

                                ForEach(tripViewModel.trips, id: \.objectID) { trip in

                                    NavigationLink {

                                        TripDetailView(
                                            trip: trip
                                            )

                                    } label: {

                                        TripCard(trip: trip)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding()
                        }
                    }
                }

                Button {

                    showAddTrip = true

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
            .navigationTitle("Trips")
            .sheet(isPresented: $showAddTrip) {
                
                NavigationStack {
                       AddTripView()
                   }
                   .environmentObject(tripViewModel)
            }
        }
    }
}

#Preview {
    TripsView()
        .environmentObject(TripViewModel())
}
