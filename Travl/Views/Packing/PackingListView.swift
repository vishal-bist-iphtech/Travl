//
//  PackingListView.swift
//  Travl
//
//  Created by iPHTech 34 on 22/07/26.
//

import SwiftUI
import CoreData

struct PackingListView: View {

    let trip: TripEntity

    @EnvironmentObject private var packingViewModel: PackingViewModel

    @State private var showAddItem = false

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            if packingViewModel.items(for: trip).isEmpty {

                ContentUnavailableView(
                    "No Packing Items",
                    systemImage: "suitcase",
                    description: Text("Start adding items for this trip.")
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            } else {

                ScrollView {

                    LazyVStack(spacing: 16) {

                        ForEach(packingViewModel.items(for: trip), id: \.objectID) { item in

                            NavigationLink {

                                PackingDetailView(item: item)

                            } label: {

                                PackingItemRow(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                    .padding(.bottom, 90) // Leave room for the FAB
                }
            }

            Button {

                showAddItem = true

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
        .navigationTitle("Packing List")
        .sheet(isPresented: $showAddItem) {

            NavigationStack {

                AddPackingItemView(trip: trip)
            }
            .environmentObject(packingViewModel)
        }
    }
}

#Preview {

    let context = PersistenceController.preview.container.viewContext

    let trip = TripEntity(context: context)

    trip.title = "Japan"

    return NavigationStack {

        PackingListView(trip: trip)
    }
    .environmentObject(PackingViewModel())
}
