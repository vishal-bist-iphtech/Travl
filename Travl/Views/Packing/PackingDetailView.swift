//
//  PackingsView.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI

struct PackingDetailsView: View {

    @EnvironmentObject private var packingViewModel: PackingViewModel
    @EnvironmentObject private var tripViewModel: TripViewModel

    @State private var showAddPackingItem = false

    private var currentTrip: TripEntity? {
        tripViewModel.nextTrip
    }

    var body: some View {

        NavigationStack {

            ZStack(alignment: .bottomTrailing) {

                ScrollView {

                    if let trip = currentTrip {

                        VStack(spacing: 20) {

                            PackingProgressCard(
                                packed: packingViewModel.packedCount(for: trip),
                                total: packingViewModel.items(for: trip).count
                            )

                            PackingCategoryGrid(
                                categories: packingViewModel.categoryBreakdown(for: trip)
                            )

                            VStack(alignment: .leading, spacing: 16) {

                                HStack {

                                    Text("Recent Items")
                                        .font(.title3.bold())

                                    Spacer()

                                    if !packingViewModel.items(for: trip).isEmpty {

                                        NavigationLink("See All") {

                                            PackingListView(trip: trip)
                                        }
                                    }
                                }

                                if packingViewModel.items(for: trip).isEmpty {

                                    ContentUnavailableView(
                                        "No Packing Items",
                                        systemImage: "suitcase",
                                        description: Text("Start building your packing checklist.")
                                    )

                                } else {

                                    ForEach(
                                        packingViewModel.recentItems(for: trip),
                                        id: \.objectID
                                    ) { item in

                                        NavigationLink {

                                            PackingDetailView(item: item)

                                        } label: {

                                            PackingItemRow(item: item)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }
                        .padding()
                        .padding(.bottom, 90)

                    } else {

                        ContentUnavailableView(
                            "No Upcoming Trip",
                            systemImage: "airplane.departure",
                            description: Text("Create a trip first.")
                        )
                        .padding()
                    }
                }

                Button {

                    showAddPackingItem = true

                } label: {

                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(.blue)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding()
            }
            .navigationTitle("Packing")
            .sheet(isPresented: $showAddPackingItem) {

                NavigationStack {

                    AddPackingItemView(
                        trip: currentTrip
                    )
                }
                .environmentObject(packingViewModel)
            }
        }
    }
}

#Preview {

    PackingDetailsView()
        .environmentObject(PackingViewModel())
        .environmentObject(TripViewModel())
}
