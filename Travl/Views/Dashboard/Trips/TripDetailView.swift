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
    @EnvironmentObject private var memoryViewModel: MemoryViewModel
    
    @State private var showMemoryOptions = false
    @State private var showAddMemory = false
    @State private var showSelectMemory = false
    
    @State private var showDeleteAlert = false
    
    private var memories: [MemoryEntity] {

        let set = trip.memories as? Set<MemoryEntity> ?? []

        return set.sorted {
            ($0.date ?? .distantPast) > ($1.date ?? .distantPast)
        }
    }

    private var bookings: [BookingEntity] {

        let set = trip.bookings as? Set<BookingEntity> ?? []

        return set.sorted {
            ($0.startDate ?? .distantFuture) < ($1.startDate ?? .distantFuture)
        }
    }

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {


                VStack(alignment: .leading, spacing: 8) {

                    Text(trip.destination ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("\(trip.city ?? ""), \(trip.country ?? "")")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // MARK: Trip Information

                GroupBox("Trip Information") {

                    VStack(spacing: 16) {

                        DetailRow(
                            title: "Start Date",
                            value: trip.startDate?.formatted(date: .abbreviated, time: .omitted) ?? "-"
                        )

                        DetailRow(
                            title: "End Date",
                            value: trip.endDate?.formatted(date: .abbreviated, time: .omitted) ?? "-"
                        )

                        DetailRow(
                            title: "Budget",
                            value: "\(trip.currency ?? "") \(Int(trip.budget))"
                        )

                        DetailRow(
                            title: "Status",
                            value: trip.status ?? "-"
                        )
                    }
                }

            

            }
            .padding()
            
            VStack(alignment: .leading, spacing: 16) {

                HStack {

                    Text("Memories")
                        .font(.title3.bold())

                    Spacer()

                    Button {

                        showMemoryOptions = true

                    } label: {

                        Label("Add", systemImage: "plus")
                    }
                }

                if memories.isEmpty {

                    ContentUnavailableView(
                        "No Memories",
                        systemImage: "photo.stack",
                        description: Text("This trip doesn't have any memories yet.")
                    )

                } else {

                    ForEach(memories.prefix(3), id: \.objectID) { memory in

                        NavigationLink {

                            MemoryDetailView(memory: memory)

                        } label: {

                            MemoryCard(memory: memory)
                        }
                        .buttonStyle(.plain)
                    }

                    if memories.count > 2 {

                        NavigationLink("See All") {

                            MemoriesView(trip: trip)
                        }
                    }
                }
            }
            .confirmationDialog(
                "Add Memory",
                isPresented: $showMemoryOptions,
                titleVisibility: .visible
            ) {

                Button("Create New Memory") {

                    showAddMemory = true
                }

                Button("Add Existing Memory") {

                    showSelectMemory = true
                }

                Button("Cancel", role: .cancel) { }
            }
            .sheet(isPresented: $showAddMemory) {

                NavigationStack {

                    AddMemoryView(trip: trip)
                }
            }
            .sheet(isPresented: $showSelectMemory) {

                NavigationStack {

                    SelectMemoryView(trip: trip)
                        .environmentObject(memoryViewModel)
                }
            }
            .padding()
            
            
            VStack(alignment: .leading, spacing: 16) {

                HStack {

                    Text("Bookings")
                        .font(.title3.bold())

                    Spacer()

                    Button("Add") {

                    }
                }

                if bookings.isEmpty {

                    ContentUnavailableView(
                        "No Bookings",
                        systemImage: "ticket",
                        description: Text("This trip doesn't have any bookings yet.")
                    )

                } else {

                    ForEach(bookings.prefix(2), id: \.objectID) { booking in

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

                    if bookings.count > 2 {

                        NavigationLink("See All") {

                            BookingsView(trip: nil)
                        }
                    }
                }
            }
            .padding()
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

    let trip = TripEntity(context: context)

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
